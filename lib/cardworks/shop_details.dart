import 'package:flutter/material.dart';



class DetailScreen extends StatelessWidget{
  final String shopname;
  final String phonenumber;
  final String imgURL;
  final String address;
  final String description;
DetailScreen({this.shopname,this.phonenumber,this.address,this.imgURL,this.description});
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     appBar:AppBar(
       title: Text(shopname),
     ),
     body: Column(
       children: <Widget>[
         Container(
           height: 300,
           width: double.infinity,
           child: Padding(
             padding: const EdgeInsets.all(10),
             child: Image.network(imgURL.toString()),
           ),
         ),
         Text(
           'Address:${address}',
           style: TextStyle(
             fontSize: 20,
           ),
         ),
         SizedBox(height: 15,),
         Text(
           'Phone Number: ${phonenumber}',
           style: TextStyle(
             fontSize: 20,
           ),
         ),
         SizedBox(height: 15,),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Text(
             'ShopServices: '
                 '${description}',
             style: TextStyle(
               fontSize: 15,
             ),
           ),
         )
       ],
     ),

   );
  }

}