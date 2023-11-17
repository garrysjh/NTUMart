import 'package:frontend/main.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/widgets/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(1.3476785606754784, 103.68688598949618);

void main() => runApp(const ItemDetailsScreen(productID: 1));


class ItemDetailsScreen extends StatefulWidget {
  // const ItemDetailsScreen({super.key});
  final int? productID; // Add a field to receive the productID

  const ItemDetailsScreen({super.key, required this.productID});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  ProductResponse? product;
  Map<String, dynamic>? productData;
  Map<String, dynamic>? userData;
  String? userName;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    // Call fetchProduct when the screen is first loaded
    fetchProduct(widget.productID);
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;



    // product's information
  

    
    


    // Create a list to store Image widgets
    List<Image> imageWidgets = [];

    if (product?.getBinaryImageDataList?.isNotEmpty ?? false){// Iterate through the binaryImageDataList and convert each string to an Image widget
    for (String? binaryImageData in product!.getBinaryImageDataList!) {
      if (binaryImageData != null && binaryImageData.isNotEmpty) {
        List<int> imageBytes = base64.decode(binaryImageData);
        Image imageWidget = Image.memory(Uint8List.fromList(imageBytes));
        imageWidgets.add(imageWidget);
      }
      else {
    // Handle the case where the binary image data is empty or null
      }
    }}

    // seller's information
    String sellerName = userData?["username"] ?? '';
    String fullName = userData?["fullname"] ?? '';
    String telegramHandle = userData?["telegramHandle"] ?? '';
    String phone = userData?["phone"] ?? '';

    // profile pic
    String profilePic = userData?["profilePic"]["content"] ?? '';
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
                SizedBox(
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
                              product?.getProductName ?? '',
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5C795B),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '\$${product?.getPrice?.toStringAsFixed(2) ?? ''}',
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
                            'Quantity: ${product?.getQuantity}',
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
                        product?.getDescription ?? '',
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
                              style: const TextStyle(fontWeight: FontWeight.bold),
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

                const SizedBox(height: 5.0), //space between "Seller details" and Google Map

                // Google Map
                Container(
                  height: 200, // Adjust the height as needed
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                    initialCameraPosition: const CameraPosition(
                      target: currentLocation,
                      zoom: 15.0,
                    ),
                    markers: {
                      const Marker(
                        markerId: MarkerId('seller_location'),
                        position: currentLocation,
                        infoWindow: InfoWindow(title: 'Seller Location'),
                      ),
                    },
                  ),
                ),

                const SizedBox(height: 5.0), //space between Google Map and "Contact seller" button


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
                        child: SizedBox(
                          height: 60, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle contact seller button click
                              _launchTelegram(telegramHandle);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5D7395), // Background color
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

  void fetchProduct(int? productID) async {
    print('fetchProduct called');
    final url = Uri.parse('$URL/product/$productID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          product = ProductResponse.fromMap(json);
          productData = json;
          userName = productData?["sellerName"] ?? '';
          // fetchUser("example_username");
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
    final url = "$URL/user/info/?username=$userName"; // Replace with the device's IPv4 address (the one that's hosting the backend)
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