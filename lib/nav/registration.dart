import 'package:flutter/material.dart';

import 'drawer.dart';
class RegistrationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Be a Mechanic'),

        ),
        drawer: MainDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('We are in Registration Screen')
            ],
          ),

        )
    );
  }

}