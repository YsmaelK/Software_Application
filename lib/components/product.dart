import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;
  String ref = 'product';

  void uploadProduct( {required String productName, required List images, required double price}) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).doc(productId).set({
      'name': productName,
      'id': productId,

    });
  }
}