import 'package:flutter/material.dart';

class TopBarRoot extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final String title;

  TopBarRoot({this.appBar, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        backgroundColor: Colors.red[300],
        elevation: 0.0,
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}