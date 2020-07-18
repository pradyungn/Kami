import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Item> items = [
    Item(text: "Lorem ipsum dolor sit amet", title: "Very long book"),
    Item(
      text: "sldk sdlfh sldkf smkdf sbdln sndfklnds kd fdkf ",
      title: "Short article",
    ),
    Item(text: "item", title: "idk", summary: "This has a summary!"),
  ];

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> k = GlobalKey(debugLabel: 'scaffold');
    return Scaffold(
      key: k,
      appBar: AppBar(
        title: const Text('Kami'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              k.currentState
                  .showSnackBar(SnackBar(content: const Text("Adding item")));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              k.currentState
                  .showSnackBar(SnackBar(content: const Text("Logging in")));
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, i) {
          if (i >= items.length) return null;
          final item = items[i];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(
                  Icons.insert_drive_file,
                  size: 48,
                ),
                const SizedBox(height: 20),
                Text("${item.title}"),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Item {
  String /*!*/ text;
  String /*!*/ title;
  String /*?*/ summary;

  Item({@required this.text, @required this.title, this.summary});
}
