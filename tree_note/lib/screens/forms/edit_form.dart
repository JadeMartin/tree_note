import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/services/database.dart';
import 'package:tree_note/shared/constants.dart';
import 'package:string_validator/string_validator.dart';



class EditForm extends StatefulWidget {


  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {


  final _formKey = GlobalKey<FormState>();
  Map data = {};
  //form values
  String _name;
  String _progress;
  String _limit;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        leading: FlatButton.icon(
            icon: Icon(Icons.arrow_back),
            label: Text('Back'),
            onPressed: () {
              Navigator.pop(context, {
                          'currentNode': currentNode
                        });
            },
          ),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Update branch info'), 
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                    initialValue: currentNode.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty? 'Please enter a branch name' : null,
                    onChanged: (val) => setState(() => _name = val),
                  ),
              SizedBox(height: 20.0),
              TextFormField(
                    initialValue: currentNode.progress.toString(),
                    decoration: textInputDecoration,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                    validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter valid current progress' : null,
                    onChanged: (val) => setState(() => _progress = val),
                  ),
              SizedBox(height: 20.0),
              TextFormField(
                    initialValue: currentNode.limit.toString(),
                    decoration: textInputDecoration,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                    validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter maximum progress' : null,
                    onChanged: (val) => setState(() => _limit = val),
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
                            if(_progress == null){
                              _progress = "0";
                            } if(_limit == null) {
                              _limit = "0";
                            } if(_name == null) {
                              _name = currentNode.name;
                            }
            
                          int progress = int.tryParse(_progress) ?? 0;
                          int limit = int.tryParse(_limit) ?? 0;
                          currentNode.update(_name, progress, limit);
                          await updateNode(currentNode);
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