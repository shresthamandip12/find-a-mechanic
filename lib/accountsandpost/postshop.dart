import 'dart:io';

import 'package:find_a_mechanic/accountsandpost/suggestion.dart';
import 'package:find_a_mechanic/nav/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

import 'addresssearch.dart';


class PostScreen extends StatefulWidget {
  PostScreen({Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() =>_PostScreenState(); //this
//or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _PostScreenState extends State<PostScreen>{
    var _image;
    var _img;
    String uri;
    String _name;
    String _phonenumber;
    String _address;

    final TextEditingController _controller = TextEditingController();
  ProgressDialog progressDialog;

  final GlobalKey<FormState>_formkey1 = GlobalKey<FormState>();

  Future getImage()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  Future getIg()async{
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _img = img;
    });
  }
  Future uploadImage() async{
    final StorageReference storageref = FirebaseStorage.instance.ref().child("Post Image");
    var timekey = new DateTime.now();
    final StorageUploadTask storageUploadtask = storageref.child(timekey.toString()+".jpeg").putFile(_image);

  }
    Widget _buildWorkshopNameTF(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Workshop Name',
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
                  String a = 'Workshop Name is required';
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
                  Icons.input,
                  color: Colors.white,
                ),
                hintText: 'Enter Workshop Name',
                hintStyle: kHintTextStyle,
              ),

            ),
          ),
        ],
      );
    }
    Widget _buildWorkshopPhoneNoTF(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Workshop Phone Number',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value){
                if(value.isEmpty){
                  String a = 'Workshop Phone Number is required';
                  return a ;
                }
                return null;
              },
              onSaved: (input)=> _phonenumber = input,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                hintText: 'Enter Workshop Phone Number',
                hintStyle: kHintTextStyle,
              ),

            ),
          ),
        ],
      );
    }
    Widget _buildWorkshopAddressTF(BuildContext context){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Workshop Phone Number',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              keyboardType: TextInputType.text,
              readOnly: true,
              validator: (value){
                if(value.isEmpty){
                  String a = 'Workshop Phone Number is required';
                  return a ;
                }
                return null;
              },
              controller: _controller,
              onTap: () async{
                final sessionToken = Uuid().v4();
               final Suggestion results = await showSearch(
                  context: context,

                  delegate: AddressSearch(sessionToken),
                );
               if(results!=null){
                 setState(() {
                   _controller.text = results.description;
                 });
               }else{
                 print("No data ");
               }
              },
              onSaved: (input)=> _address = input,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                hintText: 'Enter Address',
                hintStyle: kHintTextStyle,
              ),

            ),
          ),
        ],
      );
    }
    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
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
                  vertical: 11.0,
                ),
                child: Form(
                  key: _formkey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register Your Shop',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ), SizedBox(height: 30.0),
                        imageProfile(),
                      SizedBox(height: 30.0,),
                      _buildWorkshopNameTF(),
                      SizedBox(height: 10,),
                      _buildWorkshopPhoneNoTF(),
                      SizedBox(height: 15,),
                      _buildWorkshopAddressTF(context),


                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );

  }
    Widget imageProfile() {
      return Center(
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _image == null
                ? AssetImage("images/mechanic.png")
                : FileImage(File(_image.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: getImage,
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ]),
      );
    }

}