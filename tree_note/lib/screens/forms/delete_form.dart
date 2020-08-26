import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/services/database.dart';
import 'package:tree_note/services/search.dart';


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
    String name = currentNode.name;
    String message = 'Confirm deletion of $name and all of its children';
    if(name == ""){
      message = 'Confirm deletion of note';
    }
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (message == "Confirm deletion of note"){
                Navigator.pop(context, {
                          'currentNode': currentNode.parent
                        });
              } else {
                Navigator.pop(context, {
                            'currentNode': currentNode
                          });
              }
            },
          ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Delete'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              Text(
                message,
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
                        if (message == 'Confirm deletion of note'){
                          Navigator.pop(context, {
                            'currentNode': currentNode.parent
                          });
                        } else {
                          print(currentNode.name);
                          Navigator.pop(context, {
                            'currentNode': currentNode
                            });
                }
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
                      if(currentNode.branch) {
                        Set<TreeNode> visited = await dfs(currentNode, new Set());
                        visited.forEach((element) {deleteNode(element.id);});
                      } else {
                        deleteNode(currentNode.id);
                      }
                      Navigator.pop(context, {
                          'currentNode': currentNode.parent
                        });
                    },
              ),
              ]
            ),
            ],
          ),
          alignment: Alignment(0,0),
        ),
      )
    );
  }
}