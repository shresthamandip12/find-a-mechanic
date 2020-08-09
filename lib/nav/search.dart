import 'package:flutter/material.dart';

import 'drawer.dart';
class SearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Search For A Mechanic'),

        ),
        drawer: MainDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('We are in Search  Screen')
            ],
          ),

        )
    );
  }

}