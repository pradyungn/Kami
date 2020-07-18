import 'package:Kami/src/home.dart';
import 'package:Kami/src/input.dart';
import 'package:Kami/src/item_detail.dart';
import 'package:Kami/src/photo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
