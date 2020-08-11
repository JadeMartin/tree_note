import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/app_bar_branch.dart';
import 'package:tree_note/screens/app_bar_root.dart';
import 'package:tree_note/screens/child_list.dart';
import 'package:tree_note/screens/forms/create_branch_form.dart';
import 'package:tree_note/screens/forms/create_leaf_form.dart';

// If already created load the root for now just load a new root 

class Home extends StatelessWidget {

  final TreeNode currentNode;
  Home({this.currentNode});

  @override
  Widget build(BuildContext context) {

    void _showCreateNote() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: LeafCreateForm(currentNode: currentNode),
        );
      });
    }

    void _showCreateBranch() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: BranchCreateForm(currentNode: currentNode),
        );
      });
    }

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
            onPressed: () => _showCreateBranch(),
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.note_add),
            onPressed: () => _showCreateNote(),
        ),
      ],)
    );
  }
}
