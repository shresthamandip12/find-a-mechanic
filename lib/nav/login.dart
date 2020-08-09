import 'package:flutter/material.dart';

import 'drawer.dart';
class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),

        ),
        drawer: MainDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('We are in Login Screen')
            ],
          ),

        )
    );
  }

}