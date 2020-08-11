import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/shared/constants.dart';



class EditLeafForm extends StatefulWidget {


  @override
  _EditLeafFormState createState() => _EditLeafFormState();
}

class _EditLeafFormState extends State<EditLeafForm> {


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
        title: Text('Update note details'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                  initialValue: currentNode.note,
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
                        Navigator.pop(context, {
                          'currentNode': currentNode
                        });
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
                        currentNode.updateNote(_note);
                        Navigator.pop(context, {
                          'currentNode': currentNode.parent
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