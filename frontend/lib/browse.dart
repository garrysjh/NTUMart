import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';


void main() {
  runApp(const Search());
}

class Search extends StatelessWidget {
  const Search({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search',
      home: BrowsePage(),
      );
  }
}

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<BrowsePage> createState() => _BrowseState();
}

//
class _BrowseState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(Icons.arrow_back),
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
                      child: SearchBar(
                        leading: const Icon(Icons.search),
                        hintText: 'Search for a product',
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xFFFFFFFF),
                        ),
                        surfaceTintColor: const MaterialStatePropertyAll<Color>(
                          Color(0xFFF9F9F9),
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        elevation: null,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("browse page navigation coming soon!"),
                              duration: Duration(milliseconds: 1500),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle press on the box
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Search for user pressed!"),
                      duration: Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      const SizedBox(width: 16),
                      Text(
                        'Search for user',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}