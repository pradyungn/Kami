import 'package:Kami/src/fake_provider.dart';
import 'package:Kami/src/home.dart';
import 'package:Kami/src/input.dart';
import 'package:Kami/src/item_detail.dart';
import 'package:Kami/src/photo.dart';
import 'package:Kami/src/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FakeProvider provider = FakeProvider();
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
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        routes: {
          '/photo': (_) => PhotoView(),
          '/input': (_) => InputView(),
          '/itemDetail': (_) => ItemDetailView(),
        },
      ),
    );
  }
}
