import 'package:find_a_mechanic/nav/constants.dart';
import 'package:find_a_mechanic/nav/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:progress_dialog/progress_dialog.dart';

class ForgetPwdScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_ForgetPwdScreenState(); //this
//or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _ForgetPwdScreenState extends State<ForgetPwdScreen> {
  ProgressDialog progressDialog;
  String _email;
  final GlobalKey<FormState>_formkey1 = GlobalKey<FormState>();

  Widget _buildEmailTF() {
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

  Widget _buildForgetPwdBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => resetPassword(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Send Email ',
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
    return Scaffold(

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
                    begin: Alignment.topCenter,
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
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
                      ), SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,

                      ),

                      _buildForgetPwdBtn(context),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.style(
      message: 'Sending Password Reset Email...',
    );
    if(_formkey1.currentState.validate()){
      _formkey1.currentState.save();
      try{
        final currentUser = await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        progressDialog.show();
        print('verification mail sent');
        progressDialog.hide();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }catch(e){
        print(e.message);
      }

    }

  }
}

