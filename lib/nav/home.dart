
import 'package:find_a_mechanic/cardworks/shop.dart';
import 'package:find_a_mechanic/cardworks/shop_details.dart';
import 'package:find_a_mechanic/nav/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final shps = Provider.of<List<ShopModel>>(context);

    // TODO: implement build
   // final shopData= Provider.of<Shops>(context);
   //final shps = shopData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),

      ),
       drawer: MainDrawer(),
       body: (shps!= null)?ListView(
         children: <Widget>[
           Center(
               child: Text('Mechanic Shops',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),)
           ),
           GridView.builder(
             physics: ScrollPhysics(),
             shrinkWrap: true,
             itemCount: shps.length,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
             itemBuilder: (ctx,i){
               return  GestureDetector(
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailScreen(shopname: shps[i].shopname,phonenumber: shps[i].phone,
                     address:shps[i].address,imgURL: shps[i].imageUrl,description: shps[i].description,)));

                 },
                 child: Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: GridTile(
                     child: Image.network(shps[i].imageUrl.toString()),
                     footer: GridTileBar(
                       title:Text(shps[i].shopname),
                       backgroundColor: Colors.black87,
                     ),
                   ),
                 ),
               );
             },
           ),
         ],


       ):Center(child: CircularProgressIndicator()),
    );

  }
}