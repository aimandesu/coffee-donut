import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodDrinkProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchDonuts() async {
    return FirebaseFirestore.instance
        .collection("foods")
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<List<Map<String, dynamic>>> fetchDrinks() async {
    return FirebaseFirestore.instance
        .collection("drinks")
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<void> addItem(
    String order,
    double price,
    String image,
  ) async {
    final addItem = FirebaseFirestore.instance.collection("order");
    addItem.add({
      'name': order,
      'price': price,
      'total': price,
      'image': image,
      'paid': false,
      'count': 1,
      'username': FirebaseAuth.instance.currentUser!.uid
    }).then((value) => addItem.doc(value.id).update({
          'orderID': value.id,
        }));
  }
}
