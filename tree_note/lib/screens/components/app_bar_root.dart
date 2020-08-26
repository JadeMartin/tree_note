import 'package:flutter/material.dart';

class TopBarRoot extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final String title;

  TopBarRoot({this.appBar, this.title});

  final String helpMessage = "Treenotes is a note taking app that allows for creation of notes and folders to allow for more context to stored notes.\nTo create a folder for notes click on the folder icon for progress & max progress leave both at 0 if unsure or if you dont want to track progress this can always be updated later.\nTo create a note click the note icon and type in your note.";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image(
        image: AssetImage("lib/assets/tree_icon.png"),
        color: null
      ),
        title: Text(title),
        backgroundColor: Colors.red[300],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(context: context,
              builder: (_) => AlertDialog(
                title: Text("Info"),
                content: Text(helpMessage),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
            },
            icon: Icon(Icons.info),
           ),
        ],
      );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}