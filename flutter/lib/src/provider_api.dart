import 'dart:typed_data';

import 'package:flutter/foundation.dart';

abstract class ProviderAPI<Item extends TextItem> extends ChangeNotifier {
  /// Attempt to login with email and password. (API)
  Future<bool> loginWithEmailAndPassword(String email, String password);

  /// Attempt to login with Google. (API)
  Future<bool> loginWithGoogle();

  /// Whether we are logged in. (cached)
  bool get isLoggedIn;

  /// Log out. Does nothing if not logged in. (API)
  Future<void> logout();

  /// Recognizes text from a set of images. (API)
  Future<String> recognizeText(List<Uint8List> images);

  /// Summarizes the given text. (API)
  Future<String> summarize(String text);

  /// Stores a given text to the remote database, returning a hydrated instance
  /// with an ID which can be updated.
  Future<Item> storeText(Item text);

  /// The stored texts. (cached)
  List<Item> get storedTexts;

  /// Fetch stored texts from the remote database. (API)
  Future<void> fetchStoredTexts();
}

abstract class TextItem {
  /// Remote ID of this text.
  final String /*!*/ id;

  /// Contents of this text.
  String /*!*/ text;

  /// Title of this text.
  String /*!*/ title;

  /// Summary of this text, if available.
  String /*?*/ summary;

  TextItem.internal({
    @required this.id,
    @required this.text,
    @required this.title,
    this.summary,
  });

  /// Creates a template [TextItem], which can be hydrated by passing it to
  /// [ProviderAPI.storeText].
  TextItem({
    @required this.text,
    @required this.title,
    this.summary,
  }) : id = null;

  /// Updates the remote database with the current state of this text. (API)
  Future<void> update();
}
