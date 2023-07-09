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

  Future<void> addItem(String order, double price) async {
    final addItem = FirebaseFirestore.instance.collection("order");
    addItem.add({
      'name': order,
      'price': price,
      'paid': false,
      'username': FirebaseAuth.instance.currentUser!.uid
    });
  }
}
