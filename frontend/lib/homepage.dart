import 'package:flutter/material.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/pages/widgets/searchbar.dart';
import 'package:frontend/product.dart';
import 'package:frontend/browse.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/pages/widgets/taskbar.dart';

import 'package:frontend/category_button.dart';
import 'package:frontend/custominterests.dart';

import 'package:frontend/selling.dart';


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
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Browse()),
                              );
                            },
                          ),
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
                        Container(
                          child: VerticalViewListings(products: products),
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
