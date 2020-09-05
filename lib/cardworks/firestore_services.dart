import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_a_mechanic/cardworks/shop.dart';
import 'package:flutter/cupertino.dart';

class FireStoreService extends ChangeNotifier{
 Firestore _db = Firestore.instance;
  Stream<List<ShopModel>>getShops(){
   return _db.collection("MechanicShop").snapshots().map((snapshot) => snapshot.documents.map((document) => ShopModel.fromFirestore(document.data)).toList());
  }

}