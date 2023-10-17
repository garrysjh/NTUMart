import 'package:flutter/material.dart';
import 'package:frontend/models/productResponsemodel.dart';
import 'package:frontend/product.dart';
import 'package:frontend/item_card.dart'; 



class VerticalViewListings extends StatelessWidget {
  final List<ProductResponse> products; // Assuming Product is a defined class

  VerticalViewListings({required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.73,
          ),
          itemBuilder: (context, index) =>
              ItemCard(productResponse: products[index]),
        ),
      ),
    );
  }
}
