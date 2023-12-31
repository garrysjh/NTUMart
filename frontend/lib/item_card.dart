import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/models/productresponsemodel.dart';

class ItemCard extends StatelessWidget {
  final ProductResponse productResponse;

  const ItemCard({
    Key? key,
    required this.productResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image? imageWidget;
    if (productResponse.getProductPic != null) {
      List<int> imageBytes = base64.decode(productResponse.getProductPic!);
      Uint8List image = Uint8List.fromList(imageBytes);
      imageWidget = Image.memory(image);
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: FittedBox(
                fit:BoxFit.cover,
                  child:imageWidget ?? const Text(
                'Image will appear here',
                style: TextStyle(color: Colors.black),
              ))
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 5.0),
            child: Text(
              "${productResponse.getProductName}",
              textScaleFactor: 1.15,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            child: Text(
              "\$${productResponse.getPrice}",
              style: const TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.13,
            ),
          )
        ],
      ),
    );
  }
}