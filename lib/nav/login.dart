import 'package:flutter/material.dart';

import 'constants.dart';
import 'drawer.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_LoginScreenState(); //this
  //or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _LoginScreenState extends State<LoginScreen>{
  String _email , _password;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
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
            validator: (String value){
              if(value.isEmpty){
                return 'Email is required';
              }
            },
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
            obscureText: true,
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
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
          title: Text('Login'),

        ),
        drawer: MainDrawer(),
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
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       'Sign In',
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
                     _buildPasswordTF(),
                     _buildForgotPasswordBtn(),
                     _buildLoginBtn(),
                     _buildSignupBtn(),
                   ],
                 ),
               ),
             ),
           ),
         ],
       )
    );

  }
  void signIn(){
    final FormState formState  = _formkey.currentState;
    if(formState.validate()){

    }
  }

}