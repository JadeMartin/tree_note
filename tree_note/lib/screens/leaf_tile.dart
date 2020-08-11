import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/forms/delete_form.dart';
import 'package:tree_note/screens/forms/edit_leaf_form.dart';


class LeafTile extends StatelessWidget {

  final TreeNode node;

  LeafTile({this.node});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              subtitle: Text(node.note),
            ),
            FlatButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/editLeaf', arguments: {'currentNode': node}),
              icon: Icon(Icons.edit),
              label: Text('Edit'),
              ),
            FlatButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/DeleteConfirm', arguments: {'currentNode': node}),
              icon: Icon(Icons.delete),
              label: Text('Delete'),
              ),
          ]
        )
      ),
    );
  }
}