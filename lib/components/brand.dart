import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class BrandService{
  final _firestore  = FirebaseFirestore.instance;
  String ref = 'brands';

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();
    _firestore.collection('brands').doc(brandId).set({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands(){
    return _firestore.collection(ref).get().then((snaps){
      print(snaps.docs.length);
      return snaps.docs;
    });

  }
}