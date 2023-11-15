import 'package:flutter/material.dart';
import 'package:frontend/hallRoom/roomchat.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/browse.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/selling.dart';
import 'package:frontend/showall.dart';

class Taskbar extends StatefulWidget {
  const Taskbar({Key? key}) : super(key: key);

  @override
  State<Taskbar> createState() => _TaskbarState();
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


class _TaskbarState extends State<Taskbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints( maxWidth: 1000),
      child: BottomAppBar(
        elevation: 0,
         clipBehavior: Clip.none,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Home();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Disable animation by returning child directly
                  return child;
                },
              ),
            );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  // return const Browse();
                  return const Search(); // temporary change the browse page to showall for testing
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Disable animation by returning child directly
                  return child;
                },
              ),
            );
              },
            ),
            FloatingActionButton(
              onPressed: () {
                // Handle sell button click
                Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Sell();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Disable animation by returning child directly
                  return child;
                },
              ),
            );
              },
              child: const Icon(Icons.add),
              backgroundColor: Color(0xFF5C795B),
            ),
            IconButton(
              icon: const Icon(Icons.group),
              onPressed: () {
  // Do something
                Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const RoomChat();
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Disable animation by returning child directly
                  return child;
                },
              ),
            );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
              // The current context is not on the current page, perform the desired action
              // Check if the current route is the ProfileScreen
    if (ModalRoute.of(context)?.settings.name == '/') {
      // Already on the ProfileScreen, do nothing or handle accordingly
      Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const ProfileScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,);
        },
      ),
    );
    }
    return;
    // Navigate to the ProfileScreen
    
                // Handle profile button click
              },
            ),
          ],
        ),
      ),
    );
  }
}
