import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/pages/widgets/searchbar.dart';
import 'package:frontend/product.dart';
import 'package:frontend/browse.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/main.dart';
import 'package:frontend/category_button.dart';
import 'package:frontend/custominterests.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/selling.dart';
import 'package:frontend/pages/chatbot.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/ProductSearchBar.dart'; 
void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      home: const HomePage(title: 'Home Page'),
      initialRoute: '/',
      routes:{
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => Home(),
        '/sell': (context) =>  Sell()
      }
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

//
class _HomePageState extends State<HomePage> {
  List<String> selectedCategories = [
    "Women's Fashion",
    'Footwear',
    'Books & Notes',
    'Services',
    'Personal Care',]; //placeholder selected categories

  int? userId;
  Map<String, dynamic>? userInterestData;
  Future<List<ProductResponse>>? productsFuture;
  final TextEditingController _searchController = TextEditingController();


   
  @override
  void initState() {
    super.initState();
    fetchUserIDAndInterests();
  }

  Future<void> fetchUserIDAndInterests() async {
    userId = await JwtTokenDecryptService.getID();

    if (userId != null) {
      // Use the 'userId' as needed in this function.
      print('fetchUserIDAndInterests is called. User ID: $userId');
      fetchUserInterests(userId);
    } else {
      // Handle the case when the user ID is not available.
      print('User ID is not available');
    }
  }

  void fetchUserInterests(int? userId) async {
    print('fetchUserInterests called');
    final url = "$URL/user/checking/$userId";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          userInterestData = json;
          productsFuture = getProductsOfInterests(userInterestData);
        });

        print('fetchUserInterests completed');
      } else {
        // Handle non-200 HTTP status codes (e.g., server errors)
        print('Error: HTTP Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Handle network-related errors (e.g., SocketException, HttpException)
      print('Error: $e');
    }
  }

  Future<List<ProductResponse>> getProductsOfInterests(Map<String, dynamic>? userInterestData) async {
    String category1 = userInterestData?["category1"] ?? '';
    String category2 = userInterestData?["category2"] ?? '';
    String category3 = userInterestData?["category3"] ?? '';
    String category4 = userInterestData?["category4"] ?? '';
    String category5 = userInterestData?["category5"] ?? '';


    // final url = Uri.parse("$URL/product/listing?category=Women's Fashion");
    final url = Uri.parse("$URL/product/listing");
    final Map<String, String> requestBody = {
      'categories': "$category1, $category2, $category3, $category4, $category5",
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: SizedBox(
                    height: 750,
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .05),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Spacer(),
                              const SizedBox(
                                  width:
                                      60 //Width = size of button + sized box in between button and text
                                  ),
                              Image.asset(
                                'assets/img/ntumart_logo.png',
                                height: 50,
                              ),
                              const FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(' NTU Mart ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                      color: Color(0xFF5C795B),))),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return const ChatBot();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return child;
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  fixedSize: const Size(50, 50),
                                  shape: const CircleBorder(),
                                  backgroundColor: const Color(0xFFFFFFFF),
                                ),
                                child: Image.asset(
                                  'assets/img/chatbot_icon.png',
                                  fit: BoxFit.fill,

//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               elevation: 5,
//                               fixedSize: const Size(50, 50),
//                               shape: const CircleBorder(),
//                               backgroundColor: const Color(0xFFFFFFFF),
//                             ),
//                             child: Image.asset(
//                               '../../assets/images/chatbot_icon.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ]),
//                     const SizedBox(height: 15),
//                     const Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Searchbar()
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           const FittedBox(
//                               fit: BoxFit.fitWidth,
//                               child: Text(' Your Categories ',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600))),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               //Edit this later to link to homepage
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content:
//                                       Text('Sort function will be added l8r'),
//                                   duration: Duration(milliseconds: 1500),
//                                   behavior: SnackBarBehavior.floating,
                                ),
                              ),
                            ]),
                        SizedBox(height: MediaQuery.of(context).size.height * .01),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ProductSearchBar(controller: _searchController),  
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(' Your Categories ',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        color: Color(0xFF5C795B),))),
                              const Spacer(),

                              ElevatedButton( //Refine button (Combines both sort & filter func)
                                onPressed: (){
                                  //Edit this later to link to homepage
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Refine function will be added l8r'),
                                      duration: Duration(milliseconds: 1500),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the corner radius
                                    ),
                                  ),
                                  surfaceTintColor: const MaterialStatePropertyAll<Color>(Color(0xFFFFFFFF)),
                                  backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFFFFFFF)),
                                  elevation: null,
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('Refine',
                                      style: TextStyle(color: Color(0xFF5D7395), fontWeight: FontWeight.w600,),
                                    ),
                                    Icon(Icons.filter_alt_outlined,
                                      color: Color(0xFF5D7395),
                                    ),
                                  ],
                                ),
                              ),
                              /*
                              //Separate Sort & Filter buttons
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Sort function will be added l8r'),
                                      duration: Duration(milliseconds: 1500),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the corner radius
                                    ),
                                  ),
                                  surfaceTintColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color(0xFFFFFFFF)),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color(0xFFFFFFFF)),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 30.0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Sort',
                                      style: TextStyle(
                                          color: Color(0xFF5D7395),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.compare_arrows_rounded,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 7),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Filter function will be added l8r'),
                                      duration: Duration(milliseconds: 1500),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the corner radius
                                    ),
                                  ),
                                  surfaceTintColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color(0xFFFFFFFF)),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color(0xFFFFFFFF)),
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 30.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Filter',
                                      style: TextStyle(
                                          color: Color(0xFF5D7395),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Icon(
                                      Icons.filter_alt_rounded,
                                      color: Colors.grey.shade700,
                                    ),
                                  ],
                                ),
                              ),
                              */
                            ],
                          ),

                        ), //for row of category text + sort + filter
                        Container(
                        padding: const EdgeInsets.only(left:12, right:12),
                        height: 110,
                        child: ListView(
                          scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  for (int index = 0; index < selectedCategories.length; index++)
                                    CategoryButton(selectedString: selectedCategories[index],),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ),
                        
                        FutureBuilder<List<ProductResponse>>(
                          future: productsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Snapshot Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No data available');
                            } else {
                              return VerticalViewListings(products: snapshot.data!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
          const Spacer(),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Taskbar(),
          ),
        ],
      ),
    );
  }
}
