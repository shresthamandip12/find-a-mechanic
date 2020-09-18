import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/accountsandpost/accountactivity/yourProfiledetails.dart';
import 'package:find_a_mechanic/cardworks/shop_details.dart';
import 'package:flutter/material.dart';
class YourShopScreen extends StatefulWidget {
  final String userID;
  YourShopScreen({this.userID});
  @override
  State<StatefulWidget> createState() => _YourShopScreenState();
}
class _YourShopScreenState extends State<YourShopScreen>{
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userID);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
          ),
        title: Text('Your Mechanic Shop'),
        ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (widget.userID != '' && widget.userID !=null)
                  ?Firestore.instance
                  .collection('MechanicShop')
                  .where("userid", isEqualTo:widget.userID)
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
                          address:data['ShopeAddress'],imgURL: data['imgURL'].toString(),description: data['ShopDescription'],function: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>YourShopScreen()));},)));

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
    );
  }


}