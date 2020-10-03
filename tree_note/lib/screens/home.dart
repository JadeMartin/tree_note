import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/components/app_bar_branch.dart';
import 'package:tree_note/screens/components/app_bar_root.dart';
import 'package:tree_note/screens/components/child_list.dart';
import 'package:tree_note/services/database.dart';
import 'package:tree_note/services/loading.dart';

// If already created load the root for now just load a new root 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data =  {
  };
  
  bool loading = true;

  void setData(TreeNode node){
    setState(() => data = {'currentNode': node});
  }

  buildRoot() async {
    TreeNode root = new TreeNode(parent: null, children: [], branch: true, name: 'Root', creationTime: DateTime.now(), progress: 0, limit: 0, note:'');
    root.setId(0);
    root = await setChildren(root);
    loading = false;
    setState(() {
      data = {    
        'currentNode': root
      };
      loading = false;
    });
  }

  String isNull(TreeNode node){
    if(node == null || node.note == null){
      return "null";
    } else {
      return '\n' + node.note + '\n';
    }
  }
  
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    if (data == null){
      buildRoot();
    } else {
      loading = false;
    }

    if (loading) {
      return Loading();
    } else { 
      TreeNode currentNode = data['currentNode'];

      return Scaffold(
        appBar: currentNode.atRoot() ? TopBarRoot(appBar: AppBar(), title: 'Treenotes') : TopBarBranch(appBar: AppBar(), currentNode: currentNode, setData: setData),
        backgroundColor: Colors.brown[100],
        body: Container(
          child: currentNode.branch ? ChildList(children: currentNode.children, setData: setData) 
          : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      subtitle: Text(isNull(currentNode)),
                    ),
                  ]
                )
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              tooltip: 'Create new branch.',
              child: Icon(Icons.folder),
              onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/createBranch', arguments: {'currentNode': currentNode});
                setState(() {
                  data = {
                    'currentNode': result['currentNode'],
                  };
                });
              } 
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.note_add),
              tooltip: 'Create new note.',
              onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/createLeaf', arguments: {'currentNode': currentNode});
                setState(() {
                  data = {
                    'currentNode': result['currentNode'],
                  };
                });
              }
          ),
        ],)
      );
    }
  }
}
