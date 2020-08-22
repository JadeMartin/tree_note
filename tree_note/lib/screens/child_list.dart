import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/branch_tile.dart';
import 'package:tree_note/screens/leaf_tile.dart';

class ChildList extends StatefulWidget {

  final List<TreeNode> children;
  final Function setData;

  ChildList({this.children, this.setData});


  @override
  _ChildListState createState() => _ChildListState();
}

class _ChildListState extends State<ChildList> {
  
void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        if(newIndex > oldIndex){
          newIndex -= 1;
        }
        final TreeNode item = widget.children.removeAt(oldIndex);
        widget.children.insert(newIndex, item);
      });
    }

  Widget build(BuildContext context) {
    return ReorderableListView(
      children: widget.children.map((node) {
        print(node.id);
        return node.branch ? BranchTile(node: node, setData: widget.setData, key: ValueKey(node.id)) : LeafTile(node: node, setData: widget.setData, key: ValueKey(node.id));
      }).toList(),
      onReorder: _onReorder,
    );
  }
}