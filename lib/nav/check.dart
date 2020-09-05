import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/accountsandpost/credentials.dart';
import 'package:find_a_mechanic/accountsandpost/placeservice.dart';
import 'package:find_a_mechanic/nav/constants.dart';
import 'package:find_a_mechanic/nav/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:uuid/uuid.dart';

const kGoogleApiKey = "AIzaSyDDZcscrAvTyTwUYjaxFsGE4uZBXp8QSZw";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class PostScreenCheck1 extends StatefulWidget {
  PostScreenCheck1({Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() =>_PostScreenStateCheck1(); //this
//or State<StatefulWidget> createState(){  return _LoginScreenState(); }its same

}
class _PostScreenStateCheck1 extends State<PostScreenCheck1>{
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  final String API_KEY = 'AIzaSyDDZcscrAvTyTwUYjaxFsGE4uZBXp8QSZw';
  var _image;
  String flag = 'abc';
  String imguri;
  String _name;
  String _phonenumber;
  String _address;
  String _multiline;
  String userId;
  List<String> indexlist = [];
  String docvalue;
  final databaseref = Firestore.instance;
  final TextEditingController _controller = TextEditingController();
  ProgressDialog progressDialog;
  final db = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState>_formkey1 = GlobalKey<FormState>();

  Future getImage()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  Future uploadImage() async{
    inputData();
    if(userId!=null){
      try {
        final StorageReference storageReference = FirebaseStorage.instance.ref().child(
            "Post Image");
        var timekey = new DateTime.now();
        final StorageUploadTask storageUploadtask = storageReference.child(
            timekey.toString() + ".jpeg").putFile(_image);
        try{
          StorageTaskSnapshot taskSnapshot = await storageUploadtask.onComplete;
          var  url = await taskSnapshot.ref.getDownloadURL();

          imguri = url.toString();
        }catch(e){
          print("Error in URL");
        }
      }catch(e){
        print("Image not uploaded");
      }}else{
      print("No USerid");
    }

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
          'Workshop Address',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(controller: this._controller,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Address',
                )
            ),
            suggestionsCallback: (pattern)async {
              return await NeededData.getSuggestions(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) async {
              this._controller.text = suggestion;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a city';
              }
              return null;
            },
            onSaved: (value) => this._address = value,
          ),
        ),

      ],
    );
  }
  Widget _buildCurrentBtn(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Add Near by Location?',
          style: kLabelStyle,
        ),
      ),
    );
  }
  Widget _buildWorkshopDescriptionTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Service provided Description',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(

          ),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLength: 200,
            validator: (value){
              if(value.isEmpty){
                String a = 'Description Required';
                return a ;
              }
              return null;
            },
            onSaved: (input)=> _multiline = input,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  )),
              labelText: "Description" ,
              labelStyle: kLabelStyle,
              helperText: "Write About your Service",
              helperStyle: kLabelStyle,

            ),
            maxLines: 5,

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
        onPressed:createData,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register',
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
  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:uploadImage,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'First Upload Image',
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
                      _buildCurrentBtn(context),
                      SizedBox(height: 10,),
                      _buildWorkshopDescriptionTF(),
                      SizedBox(height: 10,),
                      _buildSaveBtn(context),
                      SizedBox(height: 10,),
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
  void inputData()async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
  }
  void createData() async {
    if(_formkey1.currentState.validate()){
      _formkey1.currentState.save();
      inputData();
      if(userId !=null) {
        try{
          List<String> splitword = _address.split(" ");

          for(int i =0; i< splitword.length; i++){
            for(int y = 0;y< splitword[i].length;y++){
              indexlist.add(splitword[i].substring(0,y).toLowerCase());
            }
          }
        }catch(e){
          print("Exception in spliting");
        }

        DocumentReference reference = await databaseref.collection("MechanicShop").add(
            {
              'ShopName': _name,
              'ShopPhone': _phonenumber,
              'ShopeAddress': _address,
              'imgURL':imguri,
              'ShopDescription': _multiline,
              'userid': userId,
              'id': flag,
              'searchindex': indexlist
            }).then((value) {
          docvalue = value.documentID ;
          return null;
        });
        print("uploades");
        print(docvalue);
        databaseref.collection("MechanicShop").document(docvalue).updateData({
          "id": docvalue,

        }).then((_) {
          print("success!");
        });

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
      }else{
        print("Error in uploading no userid ");
      }
    }
  }


}

