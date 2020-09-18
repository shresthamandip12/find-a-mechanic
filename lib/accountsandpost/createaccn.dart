import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/nav/constants.dart';
import 'package:find_a_mechanic/nav/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:progress_dialog/progress_dialog.dart';


class CreateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_CreateScreenState(); //this
//or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _CreateScreenState extends State<CreateScreen>{

  ProgressDialog progressDialog;
  String _email , _password, _confirmpwd,_name;
  bool _obscureText = true;
  bool _obscureText1 = true;
  final GlobalKey<FormState>_formkey1 = GlobalKey<FormState>();
  Widget _buildNameTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value){
              if(value.isEmpty){
                String a = 'Name is required';
                return a ;
              }
              return null;
            },
            onSaved: (input)=> _name = input,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),

          ),
        ),
      ],
    );
  }
  Widget _buildEmailTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value){
              if(value.isEmpty){
                String a = 'Email is required';
                return a ;
              }
              return null;
            },
            onSaved: (input)=> _email = input,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),

          ),
        ),
      ],
    );
  }
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (value){
              if(value.isEmpty ){

                String a = 'Password is required';
                return a ;
              }
              if(value.length < 6){
                return 'Passoword Length less than 6 ';
              }
              return null;
            },
            onSaved: (input)=> _password = input,
            obscureText: _obscureText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,

              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              suffixIcon: IconButton(icon: Icon(Icons.visibility),onPressed:(){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildConfirmtPasswordBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (value){
              if(value.isEmpty ){
                String a = 'Confirm your Password';
                return a ;
              }
              if(value.length < 6){
                return 'Password length less than 6 ';
              }
              return null;
            },
            onSaved: (input)=> _confirmpwd = input,
            obscureText: _obscureText1,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              suffixIcon: IconButton(icon: Icon(Icons.visibility),onPressed: (){
              setState(() {
                _obscureText1 = !_obscureText1;
              });
            },),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildRegisterBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,

        onPressed: () => createUserWithEmailAndPassword(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register ',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(

        backgroundColor: Color(0xfff2f3f7),
        appBar: AppBar(
          title: Text('Create Account'),

        ),

        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
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
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Form(
                  key: _formkey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register Your Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),SizedBox(height: 30.0),
                      _buildNameTF(),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(height: 20,),
                      _buildConfirmtPasswordBtn(),
                      _buildRegisterBtn(context),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );

  }
  Future<void> createUserWithEmailAndPassword(BuildContext context) async{

    progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.style(
        message: 'Creating Account...',
    );
    if(_formkey1.currentState.validate()){
      _formkey1.currentState.save();
      if(_password == _confirmpwd){
      try{
        final currentUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password,);
        DocumentReference reference = await Firestore.instance.collection("User").document(currentUser.user.uid).setData(
            {
              'Your Name': _name,
              'Your Email': _email,
            }).then((_) {
              print("upload successfull");
              return null;
        });
        if(currentUser.user.uid != null){
          progressDialog.show();
          await currentUser.user.sendEmailVerification();

              progressDialog.hide();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

        }
      }catch(e){
        print(e.message);
      }
      }else{
        showAlertDialog(context,'Password Error','Password mismatched');
        print('Password not matched');
      }
    }


  }
  showAlertDialog(BuildContext context,String txt1,String txt2) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
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