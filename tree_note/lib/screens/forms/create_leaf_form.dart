import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/services/database.dart';
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
  final maxLines = 10;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, {
                          'currentNode': currentNode
                        });
            },
          ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Create new note'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.all(24),
                height: maxLines * 24.0,
                child: TextFormField(
                      maxLines: maxLines,
                      decoration: textLeafInputDecoration,
                      validator: (val) => val.isEmpty? 'Please enter a note' : null,
                      onChanged: (val) => setState(() => _note = val),
                    ),
              ),
              SizedBox(height: 1.0),
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
                          TreeNode newNode = new TreeNode(parent: currentNode, children: [], branch: false, name: "", creationTime: DateTime.now(), progress: 0, limit: 0, note:'\n' + _note);
                          currentNode.addChild(newNode);
                          newNode.setParentId(currentNode.id);
                          newNode.setId(await insertNode(newNode));
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