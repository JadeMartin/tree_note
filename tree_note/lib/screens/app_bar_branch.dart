import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';

class TopBarBranch extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final TreeNode currentNode;

  TopBarBranch({this.appBar, this.currentNode});

  @override
  Widget build(BuildContext context) {

    //TODO add back on top bar


    return AppBar(
        title: Text(currentNode.name),
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/editBranch', arguments: {'currentNode': currentNode}),
            icon: Icon(Icons.edit),
            label: Text('Edit'),
           ),
           FlatButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/DeleteConfirm', arguments: {'currentNode': currentNode}),
            icon: Icon(Icons.delete),
            label: Text('Delete'),
           ),
        ],
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}