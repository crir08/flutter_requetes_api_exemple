import 'package:flutter/material.dart';
import 'package:requetes_api/pages/albums.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Networking',
      home: Albums(),
    );
  }
}
