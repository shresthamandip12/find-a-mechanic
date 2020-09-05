import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel with ChangeNotifier {
  final String id;
  final String shopname;
  final String address;
  final String phone;
  final String description;
  final String imageUrl;

  ShopModel({
    @required this.id,
    @required this.shopname,
    @required this.phone,
    @required this.address,
    @required this.description,
    @required this.imageUrl});

  ShopModel.fromFirestore(Map<String, dynamic> data) :
      id =data['id'],
      shopname = data['ShopName'],
     address = data['ShopeAddress'],
      phone = data['ShopPhone'],
        description = data['ShopDescription'],
      imageUrl = data['imgURL'];



}



class Shops with ChangeNotifier{
  List<ShopModel> _items = [
  ShopModel(
  id: '1',
  shopname: 'All in One Shop',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '2',
  shopname: 'All in One Shop2',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '3',
  shopname: 'All in One Shop3',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '4',
  shopname: 'All in One Shop4',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '5',
  shopname: 'All in One Shop5',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '6',
  shopname: 'All in One Shop6',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '7',
  shopname: 'All in One Shop7',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ShopModel(
  id: '8',
  shopname: 'All in One Shop8',
  phone: '9842030177',
  address: 'Chabhil,Kathmandu',
  description: "We Provide Both Car and Bike Repairing Services",
  imageUrl: 'https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg'
  ),
  ];

  List<ShopModel> get items{
  return[..._items];
  }

  }


