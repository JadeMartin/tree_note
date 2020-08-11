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
        title: Text('Create new note'),
      ),
      body: Container(
        width: 100.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                    decoration: textLeafInputDecoration,
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
                          Navigator.pop(context, {
                          'currentNode': currentNode
                        });
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
                          TreeNode newNode = new TreeNode(parent: currentNode, children: [], branch: false, name: "", creationTime: DateTime.now(), progress: 0, limit: 0, note:_note);
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