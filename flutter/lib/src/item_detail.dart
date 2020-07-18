import 'package:Kami/src/home.dart';
import 'package:flutter/material.dart';

class ItemDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(item.text),
            if (item.summary != null)
              SelectableText('Summary: ${item.summary}')
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No summary generated'),
                  const SizedBox(width: 8),
                  RaisedButton(
                    child: const Text('Summarize'),
                    onPressed: () => print('create summary'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
