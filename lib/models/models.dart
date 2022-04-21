import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MUser {
  String? email;
  String? fName;
  String? sName;
  List? myCart;
  final String phone;
  MUser({required this.phone});
}

// Grocery item model
class MGrocery {
  final String name;
  final String url;
  final String description;
  final double price;

  final num quantity = 1;
  MGrocery(
      {required this.name,
      required this.url,
      required this.description,
      required this.price});
}

// Categories item model
class MCategory {
  final String title;
  final String url;
  final Color color;

  MCategory({required this.title, required this.url, required this.color});
}

// Cart item model
class MCartItem {
  DocumentSnapshot<Object> product;
  num quantity;

  MCartItem({required this.product, required this.quantity});
}

class MGroceries {
  final String title;
  final Color color;
  final String url;

  MGroceries({required this.title, required this.color, required this.url});
}
