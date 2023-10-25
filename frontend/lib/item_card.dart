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
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: (MediaQuery.of(context).size.height)*0.2,
            //width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              //clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  product.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 6.0, 0.0, 0.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom:3),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${product.name}",
                    //textScaleFactor: 1.9,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("\$${product.price}",
                      style: TextStyle(
                          fontSize: 10,
                      ),
                      //textScaleFactor: 1.13
                  ),
                ),
              ],
            ),
          ),
          /*
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text(
              "${product.name}",
              textScaleFactor: 1.15,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            child: Text("\$${product.price}",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.13),
          )
          */
        ],
      ),
    );
  }
}
