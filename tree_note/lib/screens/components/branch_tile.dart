import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';


class BranchTile extends StatelessWidget {

  final TreeNode node;
  final Function setData;
  final Key key;
  
  BranchTile({this.node, this.setData, this.key}) : super(key: key);

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
            title: Text(node.name),
            subtitle: Text(node.progressOutput()),
          ),
        ),
      )
    );
  }
}