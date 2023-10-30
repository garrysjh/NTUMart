
import 'package:flutter/material.dart';

class Follow {
  final int id;
  final String imageURL;
  final String poster;
  final String description; 
  final String seller; 

  Follow({
    required this.id,
    required this.imageURL,
    required this.poster,
    required this.description,
    required this.seller,
  });
}

List<Follow> follow = [
  Follow(
    id: 1,
    imageURL: "assets/UsedShoes.webp",
    poster: "John Doe",
    description: "Some description for product 1",
    seller: "Seller 1",
  ),
  Follow(
    id: 2,
    imageURL: "assets/Keyboard.jpg",
    poster: "Jane Doe",
    description: "Some description for product 2",
    seller: "Seller 2",
  ),
  Follow(
    id: 3,
    imageURL: "assets/KoreanTextbook.webp",
    poster: "James Smith",
    description: "Some description for product 3",
    seller: "Seller 3",
  ),
  Follow(
    id: 4,
    imageURL: "assets/dyson.webp",
    poster: "Jessica Johnson",
    description: "Some description for product 4",
    seller: "Seller 4",
  ),
];
