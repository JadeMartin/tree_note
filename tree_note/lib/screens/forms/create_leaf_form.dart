import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/shared/constants.dart';


class LeafCreateForm extends StatefulWidget {


  @override
  _LeafCreateFormState createState() => _LeafCreateFormState();
}

class _LeafCreateFormState extends State<LeafCreateForm> {


  final _formKey = GlobalKey<FormState>();
  Map data = {};
  //form values
  String _note;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Create new note'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.backup),
            label: Text('Back'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty? 'Please enter a note' : null,
                    onChanged: (val) => setState(() => _note = val),
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
                        'Create',
                        style: TextStyle(color:Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          TreeNode newNode = new TreeNode(parent: currentNode, children: [], branch: true, name: "", creationTime: DateTime.now(), progress: 0, limit: 0, note:_note);
                          currentNode.addChild(newNode);
                          Navigator.pop(context, {
                            'currentNode': currentNode
                          });
                        }
                      },
                ),
                ]
              ),
            ],
            )
        )
      )
    );
  }
}