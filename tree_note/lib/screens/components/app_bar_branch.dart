import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';

class TopBarBranch extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final TreeNode currentNode;
  final Function setData;
  TopBarBranch({this.appBar, this.currentNode, this.setData});


  @override
  Widget build(BuildContext context) { 
    String name = currentNode.branch ? currentNode.name : currentNode.parent.name+"/Note";
    return AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setData(currentNode.parent);
            },
          ),
        title: Text(name),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              dynamic result;
              if(currentNode.branch){
                result = await Navigator.pushNamed(context, '/editBranch', arguments: {'currentNode': currentNode});
              } else {
                result = await Navigator.pushNamed(context, '/editLeaf', arguments: {'currentNode': currentNode});

              }
              setData(result['currentNode']);
            },
            icon: Icon(Icons.edit),
           ),
           IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/confirmDelete', arguments: {'currentNode': currentNode});
              setData(currentNode.parent);
            },
            icon: Icon(Icons.delete),
           ),
        ],
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}