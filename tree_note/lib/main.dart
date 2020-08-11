import 'package:flutter/material.dart';
import 'package:tree_note/screens/forms/create_branch_form.dart';
import 'package:tree_note/screens/forms/create_leaf_form.dart';
import 'package:tree_note/screens/forms/delete_form.dart';
import 'package:tree_note/screens/forms/edit_form.dart';
import 'package:tree_note/screens/forms/edit_leaf_form.dart';
import 'package:tree_note/screens/home.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/createBranch': (context) => BranchCreateForm(),
      '/createLeaf': (context) => LeafCreateForm(),
      '/editBranch': (context) => EditForm(),
      '/editLeaf': (context) => EditLeafForm(),
      '/confirmDelete': (context) => DeleteConfirm(),
    },
  ));
}