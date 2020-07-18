import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class InputView extends StatefulWidget {
  @override
  _InputViewState createState() => _InputViewState();
}

class _InputViewState extends State<InputView>
    with SingleTickerProviderStateMixin {
  TextEditingController _tc;
  AnimationController _ac;

  @override
  void initState() {
    super.initState();
    _tc = TextEditingController();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
          if (_tc.text.trim().isNotEmpty)
            FadeScaleTransition(
              animation: _ac,
              child: FloatingActionButton(
                child: const Icon(Icons.check, color: Colors.white),
                backgroundColor: Colors.green,
                onPressed: () => _onAccept(context),
              ),
            ),
        ],
      ),
    );
  }

  void _onAccept(BuildContext context) {
    final t = _tc.text.trim();
    if (t.isEmpty) return;
    Navigator.pop(context, t);
  }
}
