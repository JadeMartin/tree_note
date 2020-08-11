import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/forms/delete_form.dart';
import 'package:tree_note/screens/forms/edit_leaf_form.dart';


class LeafTile extends StatelessWidget {

  final TreeNode node;

  LeafTile({this.node});

  @override
  Widget build(BuildContext context) {

    void _showEditPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: EditLeafForm(currentNode: node),
        );
      });
    }

    void _showDeleteConfirmPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: DeleteConfirm(currentNode: node),
        );
      });
    }


    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              subtitle: Text(node.note),
            ),
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
          ]
        )
      ),
    );
  }
}