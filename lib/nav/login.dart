import 'package:flutter/material.dart';

import 'drawer.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_LoginScreenState(); //this
  //or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _LoginScreenState extends State<LoginScreen>{
  String _email , _password;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea( child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfff2f3f7),
        appBar: AppBar(
          title: Text('Login'),

        ),
        drawer: MainDrawer(),
       body: Form(
         key: _formkey,
         child: Column(
           children: <Widget>[
             TextFormField(
                validator:(input){
                  // ignore: missing_return
                  if(input.isEmpty){

                    return "Please type an email";
                  }
                },
               onSaved:(input)=> _email = input ,
               decoration: InputDecoration(labelText: 'Email'),

             ),
             TextFormField(
               // ignore: missing_return
               validator:(input){
                 if(input.isEmpty){
                   return 'Please type an password';
                 }
               },
               onSaved:(input)=> _password= input ,
               decoration: InputDecoration(labelText: 'password'),
               obscureText: true,

             ),
             RaisedButton(
               onPressed: (){},
               child: Text('Login'),
             )

           ],
         ),
       ),
    ),
    );
  }
  void signIn(){
    final FormState formState  = _formkey.currentState;
    if(formState.validate()){

    }
  }

}