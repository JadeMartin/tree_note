import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';


class BranchTile extends StatelessWidget {

  final TreeNode node;
  
  BranchTile({this.node});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: (){
          Navigator.pop(context, {
                        'currentNode': node
                      });
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(node.name),
            //TODO add progress subtitle
          ),
        ),
      )
    );
  }
}