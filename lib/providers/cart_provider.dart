import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> readCart() async* {
    yield* FirebaseFirestore.instance
        .collection('order')
        .where('username', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('paid', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<void> updateCart(String action, String orderID, int count) async {
    final item = FirebaseFirestore.instance.collection("order").doc(orderID);

    if (action == "add") {
      count = count + 1;
      item.update({
        'count': count,
      });
    } else {
      count = count - 1;
      if (count == 0) return;
      item.update({
        'count': count,
      });
    }
  }
}
