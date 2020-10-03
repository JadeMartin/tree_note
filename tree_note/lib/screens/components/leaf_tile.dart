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
      return '\n' + note + '\n';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      key: key,
      padding: EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: (){
                setData(node);
              },
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          subtitle: Text(isNull(node)),
          ),
        ),
      ),
    );
  }
}
