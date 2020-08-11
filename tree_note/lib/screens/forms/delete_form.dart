import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';


class DeleteConfirm extends StatefulWidget {

  @override
  _DeleteConfirmState createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        leading: FlatButton.icon(
            icon: Icon(Icons.arrow_back_ios),
            label: Text('Back'),
            onPressed: () {
              Navigator.pop(context, {
                          'currentNode': currentNode
                        });
            },
          ),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Delete'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                      Navigator.pop(context, {
                          'currentNode': currentNode
                        });
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