import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/services/database.dart';
import 'package:tree_note/services/loading.dart';
import 'package:tree_note/services/search.dart';
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
  final maxLines = 10;
  List<TreeNode> allBranchs = List<TreeNode>();
  bool loading = true;
  // ignore: avoid_init_to_null
  TreeNode selectedNode = null;

  loadingCheck(TreeNode currentNode) async {
    allBranchs = await getAllBranchs();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];
    if(loading) {
      loadingCheck(currentNode);
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, {
                            'currentNode': currentNode.parent
                          });
              },
            ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Update note details'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButton<TreeNode>(
                  hint: Text("Select parent node"),
                  value: selectedNode,
                  onChanged: (TreeNode value){
                    setState(() {
                      selectedNode = value;
                    });
                  },
                  items: allBranchs.map((TreeNode node){
                    return DropdownMenuItem<TreeNode>(
                      value: node,
                      child: Row(children: <Widget>[
                        Text(node.name)
                      ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 1.0),
              new Container(
                  margin: EdgeInsets.all(24),
                  height: maxLines * 24.0,
                  child: TextFormField(
                        maxLines: maxLines,
                        initialValue: currentNode.note,
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
                            'currentNode': currentNode.parent
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
                          if(_note != null) {
                            currentNode.updateNote(_note);
                          }
                          if(selectedNode != null){
                            if(selectedNode.id != currentNode.parent.id){
                              TreeNode newParent = await initDFS(selectedNode.id, currentNode);
                              if (await initParentDFS(newParent, currentNode)) {
                                  newParent.setParent(currentNode.parent);
                                }
                              currentNode.parent.removeChild(currentNode);
                              newParent.addChild(currentNode);
                              currentNode.setParent(newParent);
                              currentNode.setParentId(newParent.id);
                            }
                            if(_note != null || selectedNode != null){
                              await updateNode(currentNode);
                            }
                          }
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
}