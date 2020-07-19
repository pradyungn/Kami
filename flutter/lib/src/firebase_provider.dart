import 'dart:convert';
import 'dart:typed_data';

import 'package:Kami/src/provider_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'firebase_provider.g.dart';

const OCR_ENDPOINT = 'https://api.kamiapp.ml/ocr';
const NLP_ENDPOINT = 'https://api.kamiapp.ml/nlp';

class FirebaseProvider extends ChangeNotifier
    implements ProviderAPI<FirebaseItem> {
  List<FirebaseItem> _storedTexts = [];
  FirebaseUser _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _store = Firestore.instance;

  @override
  Future<void> fetchStoredTexts() async {
    if (!isLoggedIn) return;
    final texts =
        (await _store.collection(_user.uid).getDocuments()).documents.map(
      (e) {
        var item = FirebaseItem.fromJson(e.data);
        return item._hydrate(e.documentID, this);
      },
    );
    _storedTexts = texts;
    notifyListeners();
  }

  @override
  bool get isLoggedIn => _user != null;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      _user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount user = await _googleSignIn.signIn();
      final GoogleSignInAuthentication auth = await user.authentication;
      final AuthCredential cred = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      _user = (await _auth.signInWithCredential(cred)).user;

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  @override
  Future<String> recognizeText(List<Uint8List> images) {
    // TODO: implement recognizeText
    throw UnimplementedError();
  }

  @override
  Future<bool> signup(String email, String password) async {
    try {
      _user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<FirebaseItem> storeText(FirebaseItem text) async {
    if (!isLoggedIn) return text;
    var text2 = text;
    final c = _store.collection(_user.uid);
    if (text2.id != null) {
      // Update
      await c.document(text2.id).setData(text.toJson());
    } else {
      // Create
      final d = await c.add(text2.toJson());
      text2 = text2._hydrate(d.documentID, this);
    }
    _storedTexts = _storedTexts.where((x) => x.id != text2.id).toList()
      ..add(text2);
    return text2;
  }

  @override
  List<FirebaseItem> get storedTexts => _storedTexts;

  @override
  Future<String> summarize(String text) async {
    final resp = await http.post(
      NLP_ENDPOINT,
      body: jsonEncode({
        'text': text,
      }),
    );
    final dec = jsonDecode(resp.body) as Map<String, String>;
    return dec['output'];
  }
}

@JsonSerializable(includeIfNull: true)
class FirebaseItem extends TextItem {
  @JsonKey(ignore: true)
  final FirebaseProvider _provider;

  FirebaseItem._({
    @required FirebaseProvider provider,
    @required String id,
    @required String text,
    @required String title,
    String summary,
  })  : _provider = provider,
        super.internal(
          id: id,
          text: text,
          title: title,
          summary: summary,
        );

  FirebaseItem({
    @required String text,
    @required String title,
    String summary,
  })  : _provider = null,
        super(
          text: text,
          title: title,
          summary: summary,
        );

  @override
  Future<void> update() async {
    await _provider.storeText(this);
  }

  FirebaseItem _hydrate(String id, FirebaseProvider provider) {
    return FirebaseItem._(
      provider: provider,
      id: id,
      text: text,
      title: title,
      summary: summary,
    );
  }

  factory FirebaseItem.fromJson(Map<String, dynamic> json) =>
      _$FirebaseItemFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseItemToJson(this);
}
