import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TreeNode root = new TreeNode(parent: null, children: [], branch: true, name: 'Root', creationTime: DateTime.now(), progress: 0, limit: 0, note:'');
  @override
  Widget build(BuildContext context) {
    return Home(currentNode: root);
  }
}
