import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/home.dart';


void main() {
  final TreeNode root = new TreeNode(parent: null, children: [], branch: true, name: 'Root', creationTime: DateTime.now(), progress: 0, limit: 0, note:'');
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(currentNode: root),
    },
  ));
}