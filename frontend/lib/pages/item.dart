import 'package:dip/widgets/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  Map<String, dynamic>? productData;
  Map<String, dynamic>? userData;
  String? userName;

  @override
  void initState() {
    super.initState();
    // Call fetchProduct when the screen is first loaded
    fetchProduct();
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // product's information
    String productName = productData?["productName"] ?? '';
    String description = productData?["description"] ?? '';
    double price = productData?["price"]?.toDouble() ?? -1.0;
    int quantity = productData?["quantity"]?.toInt() ?? -1;
    String productPic = productData?["productImages"][0]["content"] ?? '';
    String productPic2 = productData?["productImages"][1]["content"] ?? '';
    String productPic3 = productData?["productImages"][2]["content"] ?? '';
    String productPic4 = productData?["productImages"][3]["content"] ?? '';

    List<String?> binaryImageDataList = [
      productPic,
      productPic2,
      productPic3,
      productPic4,
    ];

    // Create a list to store Image widgets
    List<Image> imageWidgets = [];

    // Iterate through the binaryImageDataList and convert each string to an Image widget
    for (String? binaryImageData in binaryImageDataList) {
      if (binaryImageData != null && binaryImageData.isNotEmpty) {
        List<int> imageBytes = base64.decode(binaryImageData);
        Image imageWidget = Image.memory(Uint8List.fromList(imageBytes));
        imageWidgets.add(imageWidget);
      }
      else {
    // Handle the case where the binary image data is empty or null
      }
    }

    // seller's information
    String sellerName = userData?["username"] ?? '';
    String fullName = userData?["fullname"] ?? '';
    String telegramHandle = userData?["telegramHandle"] ?? '';
    String phone = userData?["phone"] ?? '';
    String profilePic = userData?["profilePic"]["content"] ?? '';

    // profile pic
    List<int> profilePicBytes = base64.decode(profilePic);
    Image profilePicWidget = Image.memory(Uint8List.fromList(profilePicBytes));


    return MaterialApp(
      home: Scaffold(

        body: Container(
          color: const Color(0xFFF8F8F8),
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Slide show of item's images
                Container(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: imageWidgets,
                  ),
                ),

                // Display name, quantity, and price
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5C795B),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '\$${price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D7395),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0), // Add spacing between rows
                      Row(
                        children: <Widget>[
                          Text(
                            'Quantity: $quantity',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0), // Adjust the spacing as needed
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),


                // Seller details
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3), // Set the background color
                      borderRadius: BorderRadius.circular(12.0), // Add rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 24.0, // Make the avatar smaller
                              // backgroundImage: AssetImage('assets/img/avatar.jpg'),
                              backgroundImage: profilePicWidget.image,
                            ),
                            const SizedBox(width: 12.0), // Increase the space between the avatar and text
                            // Bold the username
                            Text(
                                fullName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0), // Increase the space between rows
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/telegram.png', height: 14.0), // Make icons smaller
                            const SizedBox(width: 12.0),
                            Text(
                              'Telegram: @$telegramHandle',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/whatsapp.png', height: 14.0),
                            const SizedBox(width: 12.0),
                            Text(
                              'Phone/WhatsApp: $phone',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/dollar-symbol.png', height: 14.0),
                            const SizedBox(width: 12.0),
                            const Text(
                              'Payment methods: Cash, PayNow, Bank number',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5.0), //space between "Seller details" and "Contact seller" button
                // Contact seller button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(), // Empty container to create spacing
                      ),
                      Expanded(
                        flex: 2, // Adjust the flex value as needed
                        child: Container(
                          height: 60, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle contact seller button click
                              _launchTelegram(telegramHandle);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF5D7395), // Background color
                            ),
                            child: const Text(
                              'Contact Seller',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(), // Empty container to create spacing
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 20.0),




              ],
            ),
          ),
        ),
       bottomNavigationBar: const Taskbar(),
       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void fetchProduct() async {
    print('fetchProduct called');
    const url = "http://192.168.0.2:8080/api/v1/product/1"; // Replace with the device's IPv4 address (the one that's hosting the backend)
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          productData = json;
          userName = productData?["sellerName"] ?? '';
          fetchUser(userName);
        });

        print('fetchProduct completed');
      } else {
        // Handle non-200 HTTP status codes (e.g., server errors)
        print('Error: HTTP Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network-related errors (e.g., SocketException, HttpException)
      print('Error: $e');
    }
  } // function fetchProduct

  void fetchUser(String? userName) async {
    print('fetchUser called');
    final url = "http://192.168.0.2:8080/api/v1/user/info/?username=$userName"; // Replace with the device's IPv4 address (the one that's hosting the backend)
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          userData = json;
        });

        print('fetchUser completed');
      } else {
        // Handle non-200 HTTP status codes (e.g., server errors)
        print('Error: HTTP Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network-related errors (e.g., SocketException, HttpException)
      print('Error: $e');
    }
  } // function fetchUser

  void _launchTelegram(String telegramHandle) async {
    final url = "https://t.me/$telegramHandle";
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // Handle the error, e.g., show an error dialog or message
        print("Could not launch Telegram: Invalid URL");
      }
    } catch (e) {
      // Handle any exceptions that occur during the launching process
      print("Error launching Telegram: $e");
    }
  } // function launchTelegram

}