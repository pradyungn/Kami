import 'package:Kami/src/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailView extends StatefulWidget {
  @override
  _ItemDetailViewState createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  bool _loadingSummary = false;

  @override
  Widget build(BuildContext context) {
    final TextItem item = ModalRoute.of(context).settings.arguments;
    final largeText = Theme.of(context).textTheme.headline5;
    final black = Theme.of(context).textTheme.bodyText1.color;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final shouldDelete = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                      'Are you sure you want to delete this text? This operation is permanent and cannot be undone.'),
                  actions: [
                    FlatButton(
                      child: const Text('Cancel'),
                      textColor: black,
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    FlatButton(
                      child: const Text('Delete'),
                      textColor: Colors.red,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );
              if (shouldDelete) {
                await item.delete();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.summary != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // hack to make column fill the horizontal space
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Summary',
                              style: largeText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SelectableText(item.summary),
                      ],
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No summary generated'),
                    const SizedBox(width: 8),
                    RaisedButton(
                      child: const Text('Summarize'),
                      onPressed: _loadingSummary
                          ? null
                          : () async {
                              final api = Provider.of<ProviderAPI>(context,
                                  listen: false);
                              setState(() => _loadingSummary = true);
                              final summary = await api.summarize(item.text);
                              setState(() => item.summary = summary);
                              await item.update();
                            },
                    ),
                    if (_loadingSummary) const SizedBox(width: 8),
                    if (_loadingSummary)
                      const CircularProgressIndicator(value: null),
                  ],
                ),
              const SizedBox(height: 8),
              SelectableText(item.text),
            ],
          ),
        ),
      ),
    );
  }
}
