import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


//class to return a loading animation while the app is loading data
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.brown,
          size: 50.0
        ),
      ),
    );
  }
}
