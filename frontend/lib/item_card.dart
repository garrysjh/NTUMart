import 'package:flutter/material.dart';
import 'product.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  const ItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 165,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),),
            child:ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
              child: Image.asset(
                product.imageURL,
                fit: BoxFit.fill,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Text(
              product.name,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text("\$${product.price}", style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}