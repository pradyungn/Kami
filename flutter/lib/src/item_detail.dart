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
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
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
                        Text(
                          'Summary',
                          style: largeText,
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
                              await Future.delayed(Duration(seconds: 3));
                              final summary = await api.summarize(item.text);
                              setState(() => item.summary = summary);
                              await item.update();
                            },
                    ),
                    if (_loadingSummary)
                      const SizedBox(width: 8),
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
