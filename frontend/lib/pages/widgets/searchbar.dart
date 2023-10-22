import 'package:flutter/material.dart';
import 'package:frontend/showall.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/selling.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => Home(),
        '/sell': (context) => Sell()
      }
    );
  }
}


class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
                        leading: const Icon(Icons.search),
                        hintText: 'Search for a product',
                        //hintStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(fontWeight: FontWeight.w200)),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("browse page navigation coming soon!"),
                              duration: Duration(milliseconds: 1500),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      );}}