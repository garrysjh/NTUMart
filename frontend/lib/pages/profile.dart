import 'package:flutter/material.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import '../body.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'dart:convert';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: ProfileScreen()));

class ProfileScreen extends StatefulWidget {
  _ProfileState createState() => _ProfileState();

  const ProfileScreen({super.key});
  // Add a static property to define the route name
  static const String routeName = '/profile';
}

class _ProfileState extends State<ProfileScreen> {
  Future<List<ProductResponse>>? productsFuture;
  @override
  void initState() {
    super.initState();
    productsFuture = getProfileProducts();
  }
  
  Future<List<ProductResponse>> getProfileProducts() async {
    int? sellerId = await JwtTokenDecryptService.getID();

    // final url = Uri.parse("$URL/product/listing?category=Women's Fashion");
    final url = Uri.parse("$URL/product/listing?sellerID=$sellerId");

    try {
      final response = await http.post(
        url,
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

  @override
  Widget build(BuildContext context) {
     FutureBuilder products = FutureBuilder(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Snapshot Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  print("HELLO WORLD"); 
                  return Expanded(
                    child: VerticalViewListings(products: snapshot.data!),
                  );
                  
                }
              },
            ); 
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(
          children: <Widget>[
           
            Body(verticalView: products),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Taskbar(),
            ),
            
          ],
        ));
  }
}
