import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/forms/delete_form.dart';
import 'package:tree_note/screens/forms/edit_form.dart';

class TopBarBranch extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final TreeNode currentNode;

  TopBarBranch({this.appBar, this.currentNode});

  @override
  Widget build(BuildContext context) {

    void _showEditPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: EditForm(currentNode: currentNode),
        );
      });
    }

    void _showDeleteConfirmPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: DeleteConfirm(currentNode: currentNode),
        );
      });
    }

    return AppBar(
        title: Text(currentNode.name),
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => _showEditPanel(),
            icon: Icon(Icons.edit),
            label: Text('Edit'),
           ),
           FlatButton.icon(
            onPressed: () => _showDeleteConfirmPanel(),
            icon: Icon(Icons.delete),
            label: Text('Delete'),
           ),
        ],
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}