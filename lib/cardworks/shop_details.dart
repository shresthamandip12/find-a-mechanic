import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailScreen extends StatelessWidget {
  final String shopname;
  final String phonenumber;
  final String imgURL;
  final String address;
  final String description;
  final Function function;
  DetailScreen({this.shopname,this.phonenumber,this.address,this.imgURL,this.description,this.function});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (function ==null)?() {Navigator.of(context).pop();
       }:function ,

      ),
        title: Text(shopname),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.network(imgURL.toString()),
                decoration: BoxDecoration(
                    color: Color(0x1F000000),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)
                    ),
                    
    ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0x1F000000),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                        Text('${shopname}',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Architects Daughter',
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),

                        ),),
                      SizedBox(
                        height: 15,
                      ),


                      Text('Address: ${address} ',
                        style: TextStyle(
                          fontFamily: 'Noto_Sans_JP',
                          color: Colors.black54,
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        child: Row(
                          children: <Widget>[
                              Text('Contact: ${phonenumber}',
                               style: TextStyle(
                           fontFamily: 'Noto_Sans_JP',
                           color: Colors.red,
                              fontSize: 22.5,
                              fontWeight: FontWeight.bold,
                                     ),
                             ),
                            IconButton(icon: Icon(Icons.phone),onPressed: (){
                            _launchCaller();
                            },
                            ),
                          ],


                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),

                      Text('Service We provide:',
                        style: TextStyle(
                          fontFamily: 'Noto_Sans_JP',
                          color: Colors.indigo,
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Text('${description}',
                        style: TextStyle(
                          fontFamily: 'Noto_Sans_JP',
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void  _launchCaller()async{
    var url = "tel:${phonenumber}";
    if(await canLaunch(url)){
      await launch(url);
    }else{
      print("couldnot");
    }
  }
}



