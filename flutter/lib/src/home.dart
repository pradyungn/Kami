import 'package:Kami/src/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    final iconColor =
        Theme.of(context).brightness == Brightness.light ? 'dark' : 'light';
    final iconAsset = 'assets/kami_$iconColor.png';
    final titleStyle = Theme.of(context).textTheme.headline3.copyWith(
          color: Colors.black, /*fontWeight: FontWeight.bold*/
        );
    return Scaffold(
      key: k,
      appBar: AppBar(
        title: Image.asset(
          'assets/kami_light.png',
          width: 32,
          height: 32,
          semanticLabel: 'Kami logo',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showSheet(context, BottomSheetType.add),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              final api = Provider.of<ProviderAPI>(context, listen: false);
              showSheet(
                context,
                api.isLoggedIn
                    ? BottomSheetType.account
                    : BottomSheetType.login,
              );
            },
          ),
        ],
      ),
      body: Consumer<ProviderAPI>(
        builder: (context, api, child) {
          if (api.isLoggedIn) {
            return GridView.builder(
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
                    Navigator.pushNamed(context, '/itemDetail',
                        arguments: item);
                  },
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        iconAsset,
                        width: 48,
                        height: 48,
                        isAntiAlias: true,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kami',
                        style: titleStyle,
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: const Text('Get started'),
                    onPressed: () => showSheet(context, BottomSheetType.login),
                  ),
                ],
              ),
            );
          }
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
              return AccountSheet(
                onLogout: () async {
                  final api = Provider.of<ProviderAPI>(context, listen: false);
                  await api.logout();
                  Navigator.pop(context);
                },
              );
            case BottomSheetType.login:
              return LoginSheet(
                onLogin: () async {
                  final r = await Navigator.pushNamed(context, '/login');
                  if (r == null || !(r as bool)) {
                    print('Failed to login');
                  }
                  Navigator.pop(context);
                },
                onSignup: () async {
                  final r = await Navigator.pushNamed(context, '/signup');
                  if (r == null || !(r as bool)) {
                    print('Failed to sign up');
                  }
                  Navigator.pop(context);
                },
                onLoginWithGoogle: () async {
                  final api = Provider.of<ProviderAPI>(context, listen: false);
                  final r = await api.loginWithGoogle();
                  if (!r) {
                    print('Failed to login with google');
                  }
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

enum BottomSheetType { none, account, add, login }

class AccountSheet extends StatelessWidget {
  final void Function() onLogout;

  AccountSheet({@required this.onLogout});

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

class LoginSheet extends StatelessWidget {
  final void Function() onLogin;
  final void Function() onSignup;
  final void Function() onLoginWithGoogle;

  LoginSheet({
    @required this.onLogin,
    @required this.onSignup,
    @required this.onLoginWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: const Text('Login with email and password'),
          onTap: onLogin,
        ),
        ListTile(
          title: const Text('Sign up'),
          onTap: onSignup,
        ),
        ListTile(
          leading: const Icon(MdiIcons.google),
          title: const Text('Login with Google'),
          onTap: onLoginWithGoogle,
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
