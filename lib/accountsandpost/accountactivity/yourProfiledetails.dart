import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/accountsandpost/accountactivity/yourShop.dart';
import 'package:find_a_mechanic/accountsandpost/forgetpwd.dart';
import 'package:find_a_mechanic/nav/drawer.dart';
import 'package:find_a_mechanic/nav/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name , _email,userID;
  @override
  void initState()  {
    super.initState();
    getUserinfo();

  }
  Widget _blueColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.blue,
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo() {
    return Positioned(
      top: 100,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 280,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("User information:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("images/mechanic.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Name: ${_name}"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(""),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Email:${_email}"),
                  SizedBox(
                    width: 20,
                  ),
                  Text("")
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEditbtn(BuildContext context) {
    return Positioned(
      top: 380,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourShopScreen(userID: userID,))),
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              'Your Posted Shop',
              style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassbtn(BuildContext context) {
    return Positioned(
      top: 460,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPwdScreen())),
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              'Change Password',
              style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen.visiblecheck(UserID: userID,)));},
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _blueColors(),
            _getInfo(),
            SizedBox(height: 20.0),
            _buildEditbtn(context),
            _buildPassbtn(context),

          ],
        ),
      ),
    );
  }
  void getUserinfo()async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    print(uid);

    if(uid !=null){
      Firestore.instance.collection("User").document(uid).get().then((value){
        setState(() {
          _email = value.data["Your Email"].toString();
          _name = value.data["Your Name"].toString();
          userID = uid;
        });


        print(_email);
        print(_name);
      });
    }
  }
}
