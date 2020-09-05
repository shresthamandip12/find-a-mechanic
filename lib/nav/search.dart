import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/cardworks/shop_details.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
class SearchScreen extends StatefulWidget{
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String searchString;
  final TextEditingController _controller = TextEditingController();

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
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search a Mechanic Shop...'),
              onChanged: (val) {
                setState(() {
                  searchString = val;
                });
              },
            ),
          ),

        ),
        drawer: MainDrawer(),
        body: StreamBuilder<QuerySnapshot>(
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(shopname:  data['ShopName'],phonenumber: data['imageUrl'],
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
    );
  }
}