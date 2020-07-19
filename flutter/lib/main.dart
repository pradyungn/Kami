import 'package:Kami/src/firebase_provider.dart';
import 'package:Kami/src/home.dart';
import 'package:Kami/src/input.dart';
import 'package:Kami/src/item_detail.dart';
import 'package:Kami/src/login.dart';
import 'package:Kami/src/photo.dart';
import 'package:Kami/src/provider_api.dart';
import 'package:Kami/src/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = FirebaseProvider();
  runApp(MyApp(provider: provider));
}

class MyApp extends StatelessWidget {
  final ProviderAPI provider;

  MyApp({@required this.provider});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: MaterialApp(
        title: 'Kami',
        theme: ThemeData(
          primaryColor: const Color(0xff3A6EA5),
          accentColor: const Color(0xff243F5F),
          backgroundColor: const Color(0xffFFFFF2),
          textTheme: ThemeData.light().textTheme.apply(
                bodyColor: const Color(0xff0E0F19),
                displayColor: const Color(0xff0E0F19),
              ),
          buttonTheme: ThemeData.light().buttonTheme.copyWith(
                buttonColor: const Color(0xff243F5F),
                colorScheme: ThemeData.light()
                    .buttonTheme
                    .colorScheme
                    .copyWith(brightness: Brightness.dark),
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        routes: {
          '/photo': (_) => PhotoView(),
          '/input': (_) => InputView(),
          '/itemDetail': (_) => ItemDetailView(),
          '/login': (_) => LoginView(),
          '/signup': (_) => SignupView(),
        },
      ),
    );
  }
}
