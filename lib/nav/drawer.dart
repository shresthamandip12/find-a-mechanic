import 'dart:ui';

import 'package:find_a_mechanic/nav/home.dart';
import 'package:find_a_mechanic/nav/login.dart';
import 'package:find_a_mechanic/nav/registration.dart';
import 'package:find_a_mechanic/nav/search.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Drawer(
     child: ListView(
       children: <Widget>[
         DrawerHeader(
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin:Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: [
                 Color(0xFF73AEF5),
                 Color(0xFF61A4F1),
                 Color(0xFF478DE0),
                 Color(0xFF398AE5),
               ],
               stops: [0.1, 0.4, 0.7, 0.9],
             )
           ),
             child:Container(
               child: Column(
                 children: <Widget>[
                   Center(
                     child: Stack(children: <Widget>[
                       CircleAvatar(
                         radius: 45.0,
                         backgroundImage: AssetImage("images/mechanic.png")

                       ),

                     ]),
                   ),
                   SizedBox(height: 8,),
                   Text('Find A Mechanic',style: TextStyle(color:Colors.white,fontSize: 18.0),)
                 ],
               ),
             )),
         CustomTiles(Icons.home,' Home',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));}),
         CustomTiles(Icons.search,' Find A Mechanic',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));}),
         CustomTiles(Icons.add_box,' Be a Mechanic',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));}),
         CustomTiles(Icons.person,' Login',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}),
         CustomTiles(Icons.exit_to_app,' Logout',()=>{}),

       ],
     )

   );
  }

}
class CustomTiles extends StatelessWidget{
  IconData icon;
  String text;
  Function onTap;

  CustomTiles(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
          splashColor: Colors.cyan,
          onTap: onTap,
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Text(text,style: TextStyle(fontSize: 16.0),)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}