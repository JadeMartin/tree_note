import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/shared/constants.dart';



class EditLeafForm extends StatefulWidget {

  final TreeNode currentNode;
  EditLeafForm({this.currentNode});

  @override
  _EditLeafFormState createState() => _EditLeafFormState();
}

class _EditLeafFormState extends State<EditLeafForm> {


  final _formKey = GlobalKey<FormState>();

  //form values
  String _note;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update note details',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
                initialValue: widget.currentNode.name,
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
                    'Update',
                    style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      widget.currentNode.updateNote(_note);
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