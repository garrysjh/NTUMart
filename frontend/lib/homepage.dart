import 'package:flutter/material.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/pages/widgets/searchbar.dart';
import 'package:frontend/product.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/selling.dart';
import 'package:frontend/pages/chatbot.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 10.0,
                right: 10.0,
              ),
              child: SizedBox(
                height: 750,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                                      fontWeight: FontWeight.w700))),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const ChatBotHome()),
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
                            ),
                          ),
                        ]),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Searchbar()
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //Edit this later to link to homepage
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
                              //Edit this later to link to homepage
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
                        ],
                      ),
                    ),
                    Container(
                      // child: VerticalViewListings(products: products),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Taskbar(),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
