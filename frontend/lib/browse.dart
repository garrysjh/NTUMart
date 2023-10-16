import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/widgets/searchbar.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/product.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const Search());
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search',
      home: BrowsePage(),
    );
  }
}

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowseState();
}

class _BrowseState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          left: 10.0,
          right: 10.0,
        ),
        child: SizedBox(
          height: 750,
          child: Column(
            children: [
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return const Home();
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      },
                    ),
                    const Expanded(
                      child: Searchbar(),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Search for user pressed!"),
                      duration: Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      const SizedBox(width: 16),
                      Text(
                        'Search for user',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),

              // Add VerticalViewListings widget below
              VerticalViewListings(products: products),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Product>>  getAllProducts() async {
  final url = Uri.parse('$URL/product/listing'); // Replace with your server URL

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
      }),
    );

    if (response.statusCode == 200) {
      // Request was successful
      final jsonResponse = json.decode(response.body);
      return List<Product>.from(jsonResponse.map((model) => Product.fromJson(model)));

    } else {
      // Request failed
      return null;
    }
  } catch (e) {
    print('Error: $e');

  }
}