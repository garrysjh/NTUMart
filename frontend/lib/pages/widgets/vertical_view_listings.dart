import 'package:flutter/material.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/item_card.dart';
import 'package:frontend/pages/item.dart';  // Import the ItemDetailsScreen

class VerticalViewListings extends StatelessWidget {
  final List<ProductResponse> products;

  const VerticalViewListings({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.73,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(  // Wrap the ItemCard with GestureDetector
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailsScreen(
                      productID: products[index].getProductId, // Pass the productID
                    ),
                  ),
                );
              },
              child: ItemCard(productResponse: products[index]),
            );
          },
        ),
      ),
    );
  }
}

