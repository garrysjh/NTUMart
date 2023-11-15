import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/body.dart';
import 'package:frontend/models/productresponsemodel.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/product.dart';
import 'package:frontend/pages/widgets/horizontal_view_listings.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/homepage.dart';
import 'dart:async';

void main() {
  runApp(const Browse());
}

class Browse extends StatelessWidget {
  const Browse({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BrowsePage',
      /*theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5C795B),
          onPrimary: Color(0xFFEAEAEA),
          secondary: Color(0xFF5D7395),
          onSecondary: Color(0xFFEAEAEA),
          error: Color(0xFFF32424),
          onError: Color(0xFFF32424),
          background: Color(0xFFF9F9F9),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFEAEAEA),
          onSurface: Color(0xFF5C795B),
        ),
        useMaterial3: true,
      ),*/
      home: const BrowsePage(title: 'Home Page'),
    );
  }
}

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

//
class _BrowsePageState extends State<BrowsePage> {

    Future<List<ProductResponse>>? productsFuture;


  List<String> categories = [
    "Men's Fashion",
    "Women's Fashion",
    'Footwear',
    'Books & Notes',
    'Furniture',
    'Home Decor',
    'Food Items',
    'Electronics',
    'Mobile Gadgets',
    'Services',
    'Personal Care',
    'Health & Nutrition',
    // Add more categories as needed
  ];
  final List<String> _results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
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
                              //Edit this later to link to chatbot
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text("Add in chatbot navigation later"),
                                  duration: Duration(milliseconds: 1500),
                                  behavior: SnackBarBehavior.floating,
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
                              '../../assets/img/chatbot_icon.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ]),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SearchBar(
                        leading: const Icon(Icons.search,
                          color: Colors.black45,
                          size: 32,),
                        hintText: 'Search for a product',
                        hintStyle: const MaterialStatePropertyAll<TextStyle>(
                            TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                            )),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color(0xFFFFFFFF)),
                        surfaceTintColor: const MaterialStatePropertyAll<Color>(
                            Color(0xFFF9F9F9)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        elevation: null,
                        // onTap: () {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content:
                        //       Text("browse page navigation coming soon!"),
                        //       duration: Duration(milliseconds: 1500),
                        //       behavior: SnackBarBehavior.floating,
                        //     ),
                        //   );
                        // },
                        onSubmitted: (String searchTerm) {  // Search Bar taking Search Parameter
                          print('Search Term: $searchTerm');
                          productsFuture = searchListing(searchTerm);
                        },
                        
                      ),
                    ), //Searchbar

                    Container(
                      height: MediaQuery.of(context).size.height * .68,
                      child: SingleChildScrollView( //makes everything below searchbar scrollable
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left:15.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height:40,
                                      child: Text('All Categories',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF5C795B),),
                                        maxLines: 1,
                                      )
                                  ),
                                ],
                              ),
                            ), //AllCat text


                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                                width: double.infinity,
                                height: 300,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Number of columns in the grid
                                    mainAxisSpacing: 12.0, // Adjust the vertical spacing
                                    crossAxisSpacing: 15.0, // Adjust the horizontal spacing
                                    mainAxisExtent: 38,
                                  ),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    final textColor =
                                    index % 2 == 0
                                        ? const Color(0xFF5C795B) //If odd, green
                                        : const Color(0xFF5D7395);

                                    return ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content:
                                              Text("category navigation coming soon!"),
                                              duration: Duration(milliseconds: 1500),
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(8),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0), // Adjust the corner radius
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all(const Color(0xFFFCFCFC)), //change colour later
                                      ),
                                      child: Text(category,
                                        style: TextStyle( color: textColor, fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),

                            ), //Categories


                            const Padding(
                              padding: EdgeInsets.only(left:15.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height:40,
                                      child: Text('Search Results',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF5D7395),),
                                        maxLines: 1,
                                      )
                                  ),
                                ],
                              ),
                            ), //From People You Follow

                            Container(
                              padding: const EdgeInsets.only(left:20, right:20),
                              height: 235,
                              //Use FutureBuilder to handle asynchronous operation
                              child: FutureBuilder<List<ProductResponse>>(
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
                            ),

                            // const Padding(
                            //   padding: EdgeInsets.only(left:15.0),
                            //   child: Row(
                            //     children: [
                            //       SizedBox(
                            //           height:40,
                            //           child: Text('Recent History',
                            //             style: TextStyle(
                            //               fontSize: 22,
                            //               fontWeight: FontWeight.w600,
                            //               color: Color(0xFF5C795B),),
                            //             maxLines: 1,
                            //           )
                            //       ),
                            //     ],
                            //   ),
                            // ), //Recent Hist

                            // Container(
                            //   padding: const EdgeInsets.only(left:20, right:20),
                            //   height: 235,
                            //   child: HorizontalViewListings(products: products),
                            // ),
                            
                          ],
                        ),
                      ),
                    ),


                    // // Use FutureBuilder to handle asynchronous operation
                    //         FutureBuilder<List<ProductResponse>>(
                    //           future: productsFuture,
                    //           builder: (context, snapshot) {
                    //             if (snapshot.connectionState == ConnectionState.waiting) {
                    //               return CircularProgressIndicator();
                    //             } else if (snapshot.hasError) {
                    //               return Text('Snapshot Error: ${snapshot.error}');
                    //             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    //               return Text('No data available');
                    //             } else {
                    //               return VerticalViewListings(products: snapshot.data!);
                    //             }
                    //           },
                    //         ),
                  ],

                ),
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

  // // Handle Search
  // void _handleSearch(String searchTerm){
      
  // }

//  @override
//     void initState() {
//     // super.initState();
//     productsFuture = searchListing();
//   }

// void moveToHome() {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const Home()));
//   }
}

Future<List<ProductResponse>> searchListing(String searchTerm) async{
  final url = Uri.parse('$URL/product/listing?searchTerm=$searchTerm');
  try{
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
      // Request failed
      print('Failed to load products. Status code: ${response.statusCode}');
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
      throw Exception('Failed to load products: $e');
  }
}