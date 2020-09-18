import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/accountsandpost/placeservicecheck.dart';
import 'package:find_a_mechanic/cardworks/shop_details.dart';
import 'package:find_a_mechanic/nav/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'constants.dart';
import 'drawer.dart';
class SearchScreen1 extends StatefulWidget{
  @override
  _SearchScreenState1 createState() => _SearchScreenState1();
}

class _SearchScreenState1 extends State<SearchScreen1> {

  String searchString;
  String searchbyaddr;
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },

        ),
        title: Text("Search For Mechanical Shop"),

      ),
      drawer: MainDrawer(),
      body: Column(

        children: <Widget> [

          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    decoration: kBoxDecorationStyle1,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(controller: this._controller,
                          onChanged: (val){ setState(() {
                            searchString = val;
                            searchbyaddr = null;
                          });
                          },

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            suffixIcon: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            hintText: 'Enter Workshop Address ',

                          )
                      ),
                      suggestionsCallback: (pattern)async {
                        return await NeedsData.getSuggestions(pattern);
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


                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 85,
                  width: 100,
                  child: RaisedButton(
                    onPressed: getCurrentAddress,
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            'Search By nearby location',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                (searchbyaddr!=null)?Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (searchbyaddr  !=null)
                        ?Firestore.instance
                        .collection('MechanicShop')
                        .where("searchindex", arrayContainsAny: searchbyaddr.toLowerCase().split(" "))
                        .snapshots()
                        : Firestore.instance.collection("MechanicShop").snapshots(),
                    builder: (context,snapshot){
                      return (snapshot.connectionState == ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator()):ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(shopname:  data['ShopName'],phonenumber: data['ShopPhone'],
                                address:data['ShopeAddress'],imgURL: data['imgURL'].toString(),description: data['ShopDescription'],)
                              )
                              );

                            },
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    data['imgURL'].toString(),
                                    width: 150,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    data['ShopName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),

                                  ),
                                  Text(
                                    data['ShopeAddress'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    },
                  ),
                ):Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (searchString != '' && searchString !=null)
                        ?Firestore.instance
                        .collection('MechanicShop')
                        .where("searchindex", arrayContains: searchString.toLowerCase())
                        .snapshots()
                        : Firestore.instance.collection("MechanicShop").snapshots(),
                    builder: (context,snapshot){
                      return (snapshot.connectionState == ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator()):ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(shopname:  data['ShopName'],phonenumber: data['ShopPhone'],
                                address:data['ShopeAddress'],imgURL: data['imgURL'].toString(),description: data['ShopDescription'],)));

                            },
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    data['imgURL'].toString(),
                                    width: 150,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    data['ShopName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),

                                  ),
                                  Text(
                                    data['ShopeAddress'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    },
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
  void  getCurrentAddress ()async{
    try {
      final geoposition = await getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      double latitudedata = geoposition.latitude;
      double longtitudedata = geoposition.longitude;
      print(longtitudedata);
      print(latitudedata);
      final coordinates = new Coordinates(
          geoposition.latitude, geoposition.longitude);
      var currentAddress = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      String addressLine1 = currentAddress.first.addressLine.toString();


      setState(() {
        searchbyaddr = addressLine1.trim();
      });



    }
    catch(e){
      print("Error in sendind value");

    }

    print(searchString);



  }
}