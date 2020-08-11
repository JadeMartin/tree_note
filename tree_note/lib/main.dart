import 'package:flutter/material.dart';
import 'package:tree_note/screens/home.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  ));
}