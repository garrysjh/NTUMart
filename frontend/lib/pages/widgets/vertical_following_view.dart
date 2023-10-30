import 'package:flutter/material.dart';
import 'package:frontend/product.dart';
import 'package:frontend/item_card.dart'; 
import 'following_card.dart';
import 'follow_individual.dart'; 
import 'package:frontend/pages/widgets/taskbar.dart';


void main() {
  runApp(MaterialApp(
    home: VerticalFollowingScreen(), // Set the home property to your screen widget
  ));
}

class VerticalFollowingScreen extends StatelessWidget {
 
  VerticalFollowingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: const Color(0xFF5C795B),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(); // Add navigation logic as needed
                },
              ),
              title: const Text('Following'),
              centerTitle: true,
            ),
      body: VerticalFollowing(follows: follow),
    );
  }
}

class VerticalFollowing extends StatelessWidget {
  final List<Follow> follows;

  VerticalFollowing({required this.follows});

  @override
  Widget build(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) =>
                FollowingCard(follow: follow[index]),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Taskbar(),
      ),
    ],
  );
}
}