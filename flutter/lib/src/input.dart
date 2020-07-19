import 'package:Kami/src/firebase_provider.dart';
import 'package:Kami/src/provider_api.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputView extends StatefulWidget {
  @override
  _InputViewState createState() => _InputViewState();
}

class _InputViewState extends State<InputView>
    with SingleTickerProviderStateMixin {
  TextEditingController _tc;
  AnimationController _ac;
  bool _isLoading = false;
  TextEditingController _title;

  @override
  void initState() {
    super.initState();
    _tc = TextEditingController();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _title = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input text directly'),
      ),
      body: _getBody(context),
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    _tc.dispose();
    super.dispose();
  }

  Widget _getBody(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(value: null));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _title,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a title' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                const Text('Enter your text below'),
                Expanded(
                  child: TextField(
                    controller: _tc,
                    onChanged: (_) => setState(() {
                      if (_tc.text.trim().isNotEmpty) {
                        _ac.forward();
                      } else {
                        _ac.reverse();
                      }
                    }),
                    autofocus: true,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            if (_tc.text.trim().isNotEmpty && _title.text.isNotEmpty)
              FadeScaleTransition(
                animation: _ac,
                child: FloatingActionButton(
                  child: const Icon(Icons.check, color: Colors.white),
                  backgroundColor: Colors.green,
                  onPressed: () async => await _onAccept(context),
                ),
              ),
          ],
        ),
      );
    }
  }

  Future<void> _onAccept(BuildContext context) async {
    // Make API call and return hydrated item.
    final api = Provider.of<ProviderAPI>(context, listen: false);
    // TODO: Refactor to FirebaseItem
    final item = FirebaseItem(text: _tc.text, title: _title.text);
    final item2 = await api.storeText(item);
    Navigator.pop(context, item2);
  }
}
