import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/app_bar_branch.dart';
import 'package:tree_note/screens/app_bar_root.dart';
import 'package:tree_note/screens/child_list.dart';
import 'package:tree_note/screens/forms/create_branch_form.dart';
import 'package:tree_note/screens/forms/create_leaf_form.dart';

// If already created load the root for now just load a new root 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data =  {
    'currentNode': new TreeNode(parent: null, children: [], branch: true, name: 'Root', creationTime: DateTime.now(), progress: 0, limit: 0, note:'')
  };
  

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];

    return Scaffold(
      appBar: currentNode.atRoot() ? TopBarRoot(appBar: AppBar(), title: 'Tree Notes') : TopBarBranch(appBar: AppBar(), currentNode: currentNode),
      body: Container(
        child: ChildList(children: currentNode.children),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.folder),
            onPressed: () => Navigator.pushNamed(context, '/createBranch', arguments: {'currentNode': currentNode}),
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.note_add),
            onPressed: () => Navigator.pushNamed(context, '/createLeaf', arguments: {'currentNode': currentNode}),
        ),
      ],)
    );
  }
}
