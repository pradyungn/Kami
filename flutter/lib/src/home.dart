import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // TODO: Fetch from firebase
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
            onPressed: () => showSheet(context, BottomSheetType.add),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => showSheet(context, BottomSheetType.login),
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
          return ItemView(item);
        },
      ),
    );
  }

  void showSheet(BuildContext context, BottomSheetType state) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          switch (state) {
            case BottomSheetType.add:
              return AddSheet();
            case BottomSheetType.login:
              return LoginSheet();
            default:
              print('Reached unreachable state $state');
              return null;
          }
        });
  }
}

enum BottomSheetType { none, login, add }

class LoginSheet extends StatelessWidget {
  // TODO: Check whether user is logged in

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: const Text('Login'),
          onTap: () => print('login'),
        ),
      ],
    );
  }
}

class AddSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take a picture of text'),
          onTap: () => print('camera'),
        ),
        ListTile(
          leading: const Icon(Icons.insert_drive_file),
          title: const Text('Input text directly'),
          onTap: () => print('input'),
        ),
      ],
    );
  }
}

class ItemView extends StatelessWidget {
  final Item item;

  ItemView(this.item);

  @override
  Widget build(BuildContext context) {
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
  }
}

class Item {
  final String /*!*/ id;
  String /*!*/ text;
  String /*!*/ title;
  String /*?*/ summary;

  Item({
    @required this.id,
    @required this.text,
    @required this.title,
    this.summary,
  });

  // TODO: Update firebase when properties are modified
}
