import 'package:find_a_mechanic/accountsandpost/createaccn.dart';
import 'package:find_a_mechanic/accountsandpost/forgetpwd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'constants.dart';
import 'drawer.dart';
import 'home.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_LoginScreenState(); //this
  //or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _LoginScreenState extends State<LoginScreen>{
  ProgressDialog progressDialog;
  String _email , _password;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  bool _obscureText = true;
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
            obscureText: _obscureText,
            validator: (value){
              if(value.isEmpty ){
                String a = 'Password Required';
                return a ;
              }

              return null;
            },
            onSaved: (input)=> _password = input,
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
                  _obscureText = !_obscureText;
                });
              },),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildForgotPasswordBtn(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPwdScreen())),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }
  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => signInWithEmailAndPassword(context),
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
  Widget _buildSignupBtn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateScreen())),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Create Account?Sign up',
          style: TextStyle(color:Colors.white,fontSize: 20,)
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
                 key: _formkey,
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
                     _buildForgotPasswordBtn(context),
                     _buildLoginBtn(context),
                     _buildSignupBtn(context),
                   ],
                 ),
               ),
             ),
           ),
         ],
       )
    );

  }
  Future<void> signInWithEmailAndPassword(BuildContext context) async{
    progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.style(
      message: 'Sending Password Reset Email...',
    );
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        final currentUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        if(currentUser.user.isEmailVerified){
          progressDialog.show();
          progressDialog.hide();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          print("User Verified");
        }else{
          showAlertDialog(context,'Email', 'Email not Verified');
          print("Not Verified");
        }

      }catch(e){
        print(e.message);
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