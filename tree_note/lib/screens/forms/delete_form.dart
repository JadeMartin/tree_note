import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';


class DeleteConfirm extends StatelessWidget {

  final TreeNode currentNode;

  DeleteConfirm({this.currentNode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Confirm delete of $currentNode.name',
                style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Cancel',
                    style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                      Navigator.pop(context);
                  },
              ),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Confirm',
                    style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                    currentNode.parent.removeChild(currentNode);
                    Navigator.pop(context, {
                        'currentNode': currentNode.parent
                      });
                  },
            ),
            ]
          ),
          ],
        ),
      )
    );
  }
}