import 'package:Kami/src/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

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
            onPressed: () async {
              final api = Provider.of<ProviderAPI>(context, listen: false);
              if (api.isLoggedIn) {
                showSheet(context, BottomSheetType.account);
              } else {
                //Navigator.pushNamed(context, '/login');
                await api.loginWithGoogle();
                print('logged in = ${api.isLoggedIn}');
                await api.fetchStoredTexts();
              }
            },
          ),
        ],
      ),
      body: Consumer<ProviderAPI>(
        builder: (context, api, child) => GridView.builder(
          itemCount: api.storedTexts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 / 10,
          ),
          itemBuilder: (context, i) {
            if (i >= api.storedTexts.length) return null;
            final item = api.storedTexts[i];
            return InkWell(
              child: ItemView(item),
              onTap: () {
                print('pressed ${item.title}');
                Navigator.pushNamed(context, '/itemDetail', arguments: item);
              },
            );
          },
        ),
      ),
    );
  }

  void showSheet(BuildContext context, BottomSheetType state) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          switch (state) {
            case BottomSheetType.add:
              return AddSheet(
                onPhoto: () async {
                  print('photo');
                  final result = await Navigator.pushNamed(context, '/photo')
                      as List<Asset>;
                  print(result);
                  Navigator.pop(context);
                },
                onInput: () async {
                  print('input');
                  final result =
                      await Navigator.pushNamed(context, '/input') as String;
                  print(result);
                  Navigator.pop(context);
                },
              );
            case BottomSheetType.account:
              return LoginSheet(
                onLogout: () async {
                  final api = Provider.of<ProviderAPI>(context, listen: false);
                  await api.logout();
                  Navigator.pop(context);
                },
              );
            default:
              print('Reached unreachable state $state');
              return null;
          }
        });
  }
}

enum BottomSheetType { none, account, add }

class LoginSheet extends StatelessWidget {
  // TODO: Check whether user is logged in
  final void Function() onLogout;

  LoginSheet({@required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: const Text('Log out'),
          onTap: onLogout,
        ),
      ],
    );
  }
}

class AddSheet extends StatelessWidget {
  final void Function() onPhoto;
  final void Function() onInput;

  AddSheet({@required this.onPhoto, @required this.onInput});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Scan text from photos'),
          onTap: onPhoto,
        ),
        ListTile(
          leading: const Icon(Icons.insert_drive_file),
          title: const Text('Input text directly'),
          onTap: onInput,
        ),
      ],
    );
  }
}

class ItemView extends StatelessWidget {
  final TextItem item;

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
          Expanded(
            child: Text("${item.title}"),
          ),
        ],
      ),
    );
  }
}
