import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class CategoryService{
  final _firestore  = FirebaseFirestore.instance;
  String ref = 'categories';

  void createCategory(String name){
    var id = Uuid();
    String brandId = id.v1();
    _firestore.collection('categories').doc(brandId).set({'categories': name});
  }

  Future<List<DocumentSnapshot>> getCategory(){
    return _firestore.collection(ref).get().then((snaps){
      return snaps.docs;
    });

  }
}