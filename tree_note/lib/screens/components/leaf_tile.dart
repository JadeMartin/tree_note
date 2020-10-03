import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';



class LeafTile extends StatelessWidget {

  final TreeNode node;
  final Function setData;
  final Key key;
  LeafTile({this.node, this.setData, this.key}) : super(key: key);

  String isNull(TreeNode node){
    if(node == null || node.note == null){
      return "null";
    } else {
      String note = node.note;
      if(note.length > 250){
        note = note.substring(0, 250) + " .....";
      }
      return note;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      key: key,
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              subtitle: Text(isNull(node)),
              onTap: (){
                setData(node);
              },
            ),
          ]
        )
      ),
    );
  }
}