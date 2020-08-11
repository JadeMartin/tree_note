import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/shared/constants.dart';
import 'package:string_validator/string_validator.dart';



class EditForm extends StatefulWidget {

  final TreeNode currentNode;
  EditForm({this.currentNode});

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {


  final _formKey = GlobalKey<FormState>();

  //form values
  String _name;
  int _progress;
  int _limit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Update branch info'),
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
                    initialValue: widget.currentNode.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty? 'Please enter a branch name' : null,
                    onChanged: (val) => setState(() => _name = val),
                  ),
              SizedBox(height: 20.0),
              TextFormField(
                    initialValue: widget.currentNode.name,
                    decoration: textInputDecoration,
                    validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter valid current progress' : null,
                    onChanged: (val) => setState(() => _progress = int.parse(val)),
                  ),
              SizedBox(height: 20.0),
              TextFormField(
                    initialValue: widget.currentNode.name,
                    decoration: textInputDecoration,
                    validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter maximum progress' : null,
                    onChanged: (val) => setState(() => _limit = int.parse(val)),
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
                        'Update',
                        style: TextStyle(color:Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          widget.currentNode.update(_name, _progress, _limit);
                          Navigator.pop(context, {
                            'currentNode': widget.currentNode
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