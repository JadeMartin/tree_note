import 'package:flutter/material.dart';
import 'package:tree_note/models/tree_node.dart';
import 'package:tree_note/screens/branch_tile.dart';
import 'package:tree_note/screens/leaf_tile.dart';

class ChildList extends StatefulWidget {

  final List<TreeNode> children;
  ChildList({this.children});

  @override
  _ChildListState createState() => _ChildListState();
}

class _ChildListState extends State<ChildList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.children.length,
      itemBuilder: (context, index){
        return widget.children[index].branch ? BranchTile(node: widget.children[index]) : LeafTile(node: widget.children[index]);
      },
    );
  }
}