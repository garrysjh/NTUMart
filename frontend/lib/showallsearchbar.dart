import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/ProductSearchBar.dart'; 
import 'dart:async';

import 'package:http/http.dart' as http;

void main() {
  runApp(const NamePage(name: "Dragon"));
}
class NamePage extends StatefulWidget {
  final String? name; // Add a field to receive the productID

  const NamePage({super.key, required this.name});
  // const CategoryPage({super.key});

  @override
  State<NamePage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<NamePage> {
  late Future<List<ProductResponse>> productsFuture;
  final TextEditingController _searchController = TextEditingController(); 

  
  @override
  void initState() {
    super.initState();
    productsFuture = getNameProducts(widget.name);
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
                      Expanded(
                        child: ProductSearchBar(controller: _searchController),
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

  Future<List<ProductResponse>> getNameProducts(String? name) async {
    //final url = Uri.parse('$URL/product/listing');
    final url = Uri.parse("$URL/product/listing?searchTerm=$name" );
    try {
      final response = await http.post(
        url,
        
      );

      if (response.statusCode == 200) {
        
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.length == 0) { 
          print("No products found"); 
          return new List.empty(); 
        }
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