import 'package:Kami/src/firebase_provider.dart';
import 'package:Kami/src/home.dart';
import 'package:Kami/src/input.dart';
import 'package:Kami/src/item_detail.dart';
import 'package:Kami/src/login.dart';
import 'package:Kami/src/photo.dart';
import 'package:Kami/src/provider_api.dart';
import 'package:Kami/src/signup.dart';
import 'package:Kami/src/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = FirebaseProvider();
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeSwitcher(),
    child: MyApp(provider: provider),
  ));
}

final lightTheme = ThemeData.light().copyWith(
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
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.dark,
  accentColorBrightness: Brightness.dark,
);
final darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff243F5F),
  accentColor: const Color(0xff3A6EA5),
  backgroundColor: const Color(0xff0E0F19),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: const Color(0xffFFFFF2),
        displayColor: const Color(0xffFFFFF2),
      ),
  buttonTheme: ThemeData.dark().buttonTheme.copyWith(
        buttonColor: const Color(0xff243F5F),
        colorScheme: ThemeData.dark()
            .buttonTheme
            .colorScheme
            .copyWith(brightness: Brightness.dark),
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  primaryColorBrightness: Brightness.dark,
  accentColorBrightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  final ProviderAPI provider;

  MyApp({@required this.provider});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<ThemeSwitcher>(
        builder: (context, api, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kami',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: api.themeMode,
          home: Home(),
          routes: {
            '/photo': (_) => PhotoView(),
            '/input': (_) => InputView(),
            '/itemDetail': (_) => ItemDetailView(),
            '/login': (_) => LoginView(),
            '/signup': (_) => SignupView(),
          },
        ),
      ),
    );
  }
}
