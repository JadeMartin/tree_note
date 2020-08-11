import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';



class LeafTile extends StatelessWidget {

  final TreeNode node;
  final Function setData;
  LeafTile({this.node, this.setData});

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
            ButtonBar(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/editLeaf', arguments: {'currentNode': node});
                    setData(result['currentNode']);
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                  ),
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/confirmDelete', arguments: {'currentNode': node});
                    setData(result['currentNode']);
                  },  
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  )
              ]
            )
          ]
        )
      ),
    );
  }
}