import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'follow_individual.dart';
import 'package:frontend/pages/item_screen.dart';
import 'package:frontend/theme.dart';

class FollowingCard extends StatelessWidget {
  final Follow follow;
  const FollowingCard({
    super.key,
    required this.follow,
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
            width: 500,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.asset(
                follow.imageURL,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              "${follow.poster}",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.15,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.5),
            child: Text("${follow.description}", textScaleFactor: 1.13),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ItemDetailsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 43, 96, 108), // Background color
                
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2), // Rounded corners
                ),
                elevation: 3, // Shadow elevation
              ),
              child: Text('Check out product'), // Customize the button text
            ),
          )
        ],
      ),
    );
  }
}
