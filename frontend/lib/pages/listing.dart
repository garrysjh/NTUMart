import 'package:flutter/material.dart';
import 'package:frontend/models/listingmodel.dart';
import 'package:frontend/pages/camera.dart';
import 'package:frontend/pages/item_screen.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:convert';

//this code is to test and run pages from the page itself
void main() {
  runApp(ListingsTest());
}

class ListingsTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Listings());
  }
}

Future<List<Listing>> fetchListings() async {
  final url = Uri.parse('$URL/product/listing');
  final response = await http.post(url);
  List<Listing> listings = parseListings(response.body) ?? [];
  return listings.where((listing) => listing.getProductPic() != null).toList();
}

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5C795B),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Add navigation logic as needed
            },
          ),
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Listing>>(
          future: fetchListings(),
          builder: (BuildContext context, AsyncSnapshot<List<Listing>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data available.');
            } else {
              List<Listing> allListings = snapshot.data!;
              List<Widget> listingWidgets = [];

              for (Listing listing in allListings) {
                String productName = listing.productName ?? "No product name";
                String description = listing.description ?? "No description";
                String imageContent = "";

                if (listing.productImages != null &&
                    listing.productImages.isNotEmpty &&
                    listing.productImages[0]?.content != null) {
                  imageContent = listing.productImages[0]!.content!;
                }

                print("Listing: $listing");
                print("ProductName: $productName");
                print("Description: $description");
                print("ImageContent: $imageContent");

                if (productName != null && description != null) {
                  listingWidgets.add(ListTile(
                    title: Text(productName),
                    subtitle: Text(description),
                    leading: (imageContent.isNotEmpty)
                        ? Image.network(
                            imageContent,
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                          )
                        : Container(),
                  ));
                } else {
                  print("Null value detected in productName or description: $listing");
                }
              }

              return Stack(
                children: [
                  ListView(children: listingWidgets),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Taskbar(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}