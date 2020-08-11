import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';

class TopBarBranch extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final TreeNode currentNode;
  final Function setData;

  TopBarBranch({this.appBar, this.currentNode, this.setData});

  @override
  Widget build(BuildContext context) {

    //TODO add back on top bar


    return AppBar(
      
        title: Text(currentNode.name),
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.backup),
            label: Text('Back'),
            onPressed: () {
              setData(currentNode.parent);
            },
          ),
          FlatButton.icon(
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/editBranch', arguments: {'currentNode': currentNode});
              setData(result['currentNode']);
            },
            icon: Icon(Icons.edit),
            label: Text('Edit'),
           ),
           FlatButton.icon(
            onPressed: () async {
              await Navigator.pushNamed(context, '/confirmDelete', arguments: {'currentNode': currentNode});
              setData(currentNode.parent);
            },
            icon: Icon(Icons.delete),
            label: Text('Delete'),
           ),
        ],
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}