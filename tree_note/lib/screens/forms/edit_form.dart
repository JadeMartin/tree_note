import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/services/database.dart';
import 'package:tree_note/services/loading.dart';
import 'package:tree_note/services/search.dart';
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
  List<TreeNode> allBranchs = List<TreeNode>();  

  bool loading = true;
  // ignore: avoid_init_to_null
  TreeNode selectedNode = null;

  loadingCheck(TreeNode currentNode) async {
    allBranchs = await getAllBranchs();
    TreeNode removeNode = currentNode;
    allBranchs.forEach((element) { removeNode = (element.id == currentNode.id) ? element : removeNode;});
    allBranchs.remove(removeNode);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    TreeNode currentNode = data['currentNode'];

    if(loading){
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
                            'currentNode': currentNode
                          });
              },
            ),
          automaticallyImplyLeading: false,
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
                SizedBox(height: 20.0),
                TextFormField(
                      initialValue: currentNode.name,
                      decoration: textInputDecoration,
                      validator: (val) => val.isEmpty? 'Please enter a branch name' : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                SizedBox(height: 20.0),
                TextFormField(
                      initialValue: currentNode.progress.toString(),
                      decoration: textProgressInputDecoration,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                      validator: (val) => !isInt(val) | val.isEmpty ? 'Please enter valid current progress' : null,
                      onChanged: (val) => setState(() => _progress = val),
                    ),
                SizedBox(height: 20.0),
                TextFormField(
                      initialValue: currentNode.limit.toString(),
                      decoration: textLimitInputDecoration,
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
                                _progress = currentNode.progress.toString();
                              } if(_limit == null) {
                                _limit = currentNode.limit.toString();
                              } if(_name == null) {
                                _name = currentNode.name;
                              }
                            
                            if(selectedNode != null){
                              if(selectedNode.id != currentNode.parent.id){
                                TreeNode newParent = await initDFS(selectedNode.id, currentNode);
                                print("initParentDFS");
                                if (await initParentDFS(newParent, currentNode)) {
                                  newParent.parent.removeChild(newParent);
                                  newParent.setParent(currentNode.parent);
                                  currentNode.parent.addChild(newParent);
                                }
                                currentNode.parent.removeChild(currentNode);
                                newParent.addChild(currentNode);
                                currentNode.setParent(newParent);
                                currentNode.setParentId(newParent.id);
                              }
                            } else {
                              selectedNode = currentNode.parent;
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
}