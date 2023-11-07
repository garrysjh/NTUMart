import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'package:frontend/item_card.dart';

class HorizontalViewListings extends StatelessWidget {
  final List<Product> products; // Assuming Product is a defined class

  HorizontalViewListings({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              // for (int index = 0; index < products.length; index++)
              //   ItemCard(product: products[index]),
            ],
          ),
        ),
      ],
    );
  }
}
