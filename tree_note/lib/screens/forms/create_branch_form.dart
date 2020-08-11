import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/shared/constants.dart';
import 'package:string_validator/string_validator.dart';



class BranchCreateForm extends StatefulWidget {

  final TreeNode currentNode;
  BranchCreateForm({this.currentNode});

  @override
  _BranchCreateFormState createState() => _BranchCreateFormState();
}

class _BranchCreateFormState extends State<BranchCreateForm> {


  final _formKey = GlobalKey<FormState>();

  //form values
  String _name;
  int _progress;
  int _limit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            'Create new branch',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          TextFormField(
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty? 'Please enter a branch name' : null,
                onChanged: (val) => setState(() => _name = val),
              ),
          SizedBox(height: 10.0),
          TextFormField(
                initialValue: "0",
                decoration: textInputDecoration,
                validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter valid current progress' : null,
                onChanged: (val) => setState(() => _progress = int.parse(val)),
              ),
          SizedBox(height: 10.0),
          TextFormField(
                initialValue: "0",
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
                    'Create',
                    style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      TreeNode newNode = new TreeNode(parent: widget.currentNode, children: [], branch: true, name: _name, creationTime: DateTime.now(), progress: _progress, limit: _limit, note:'');
                      widget.currentNode.addChild(newNode);
                      Navigator.pop(context);
                    }
                  },
            ),
            ]
          ),
        ],
        )
      
    );
  }
}