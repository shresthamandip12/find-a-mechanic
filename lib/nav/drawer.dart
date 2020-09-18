import 'dart:ui';

import 'package:find_a_mechanic/nav/home.dart';
import 'package:find_a_mechanic/nav/login.dart';
import 'package:find_a_mechanic/nav/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'check.dart';
class MainDrawer extends StatefulWidget{



  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool visible = true;
    String userID;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkuserstatus();

  }
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
         CustomTiles(Icons.home,' Home',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));},true),
         CustomTiles(Icons.search,' Find A Mechanic',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen1()));},true),
         CustomTiles(Icons.add_box,' Be a Mechanic',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen.visiblecheck(UserID: userID,)));},true),

         CustomTiles(Icons.person,' Login',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));},visible),
         CustomTiles(Icons.exit_to_app,' Logout',()async{
           FirebaseAuth.instance.signOut().then((_) {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            print("Logout Successful");
           });
         },!visible),

       ],
     )

   );
  }

  void checkuserstatus()async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      final uid = user.uid;
      setState(() {
        if(uid !=null){
          userID = uid;
          visible = !visible;
          print(visible);
        }else{
          print(visible);
        }
      });
    }catch(e){
      print("user is not logged");
    }

  }
  showAlertDialog(BuildContext context,String txt1,String txt2,Function function) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: function,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(txt1),
      content: Text(txt2),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
class CustomTiles extends StatelessWidget{
  IconData icon;
  String text;
  Function onTap;
  bool visibile;
  CustomTiles(this.icon,this.text,this.onTap,this.visibile);


  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Padding(
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
      ),
      visible: visibile,
    );
  }

}