import 'package:flutter/material.dart';

class Product {
  final int id;
  final String imageURL;
  final String name;
  final double price;

  Product(
      {
        required this.id,
        required this.imageURL,
        required this.name,
        required this.price,
      });
}

List<Product> products = [
  Product(
      id: 1,
      price: 100,
      name: dummyText,
      imageURL: "assets/UsedShoes.webp",
  ) ,
  Product(
      id: 2,
      price: 200,
      name: 'Keyboard',
      imageURL: "assets/Keyboard.jpg",
  ),
  Product(
      id: 3,
      price: 16,
      name: 'Used Korean Textbook',
      imageURL: "assets/KoreanTextbook.webp",
  ),
  Product(
      id: 4,
      price: 300,
      name: 'Dyson Fan',
      imageURL: "assets/dyson.webp",
  ),

];

String dummyText =
    "UsedShoes";