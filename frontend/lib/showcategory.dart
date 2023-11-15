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
  runApp(const CategoryPage(category: "Men's Fashion"));
}

// class SearchCategory extends StatelessWidget {
//   const SearchCategory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Search',
//       home: CategoryPage(),
//     );
//   }
// }

class CategoryPage extends StatefulWidget {
  final String? category; // Add a field to receive the productID

  const CategoryPage({super.key, required this.category});
  // const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<ProductResponse>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = getCategoryProducts(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
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
      )
    );
  }

  Future<List<ProductResponse>> getCategoryProducts(String? category) async {
    //final url = Uri.parse('$URL/product/listing');
    final url = Uri.parse("$URL/product/listing");
    final Map<String, String> requestBody = {
      'categories': "$category",
    };

    try {
      final response = await http.post(
        url,
        body: requestBody,
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