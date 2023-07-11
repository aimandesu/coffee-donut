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

  Future<void> updateCart(
    String action,
    String orderID,
    int count,
    double price,
    double total,
  ) async {
    final item = FirebaseFirestore.instance.collection("order").doc(orderID);
    final priceItem = price;

    if (action == "add") {
      count = count + 1;
      item.update({
        'count': count,
        'total': total + priceItem,
      });
    } else {
      count = count - 1;
      if (count == 0) return;
      item.update({
        'count': count,
        'total': total - priceItem,
      });
    }
  }

  Future<void> pay(List<String> orderID) async {
    for (var element in orderID) {
      var item = FirebaseFirestore.instance.collection("order").doc(element);
      item.update({
        'paid': true,
      });
    }
  }

  Future<double> fetchTotalPrice(List<String> orderID) async {
    double price = 0.0;
    for (var element in orderID) {
      var item = await FirebaseFirestore.instance
          .collection("order")
          .doc(element)
          .get();

      price = price + item.data()!["total"];

      // item.then((value) {
      //   price = price + value.data()!['total'];
      //   print(price);
      // });
    }
    return price;
  }

  Future<void> deleteOrder(String orderID) async {
    final item = FirebaseFirestore.instance.collection("order").doc(orderID);
    await item.delete();
  }
}
