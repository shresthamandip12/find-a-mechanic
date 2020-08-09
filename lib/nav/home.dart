import 'package:find_a_mechanic/nav/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),

      ),
       drawer: MainDrawer(),
       body: Center(
         child: Column(
           children: <Widget>[
             Text('We are in Home Screen')
           ],
         ),

       )
    );
  }

}