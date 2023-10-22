import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:frontend/body.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/pages/widgets/searchbar.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/product.dart';

import 'dart:async';

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
  late Future<List<ProductResponse>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = getAllProducts();
  }

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

              // Use FutureBuilder to handle asynchronous operation
              FutureBuilder<List<ProductResponse>>(
                future: productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Snapshot Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available');
                  } else {
                    return VerticalViewListings(products: snapshot.data!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ProductResponse>> getAllProducts() async {
    final url = Uri.parse('$URL/product/listing');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse: ");
        print(jsonResponse.runtimeType);
        print("Type of item in jsonresponse: ");
        print(jsonResponse[0].runtimeType);
        List<ProductResponse> products = [];
        for (var item in jsonResponse) {
          final product = ProductResponse.fromMap(item);
          print("Item: ");
          print(item);
          products.add(product);
        }
        return products;
      } else {
        print('Failed to load products. Status code: ${response.statusCode}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load products: $e');
    }
  }
}