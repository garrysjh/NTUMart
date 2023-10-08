import 'package:flutter/material.dart';
import 'package:frontend/pages/item_screen.dart';
import 'package:frontend/pages/profile.dart';

class Taskbar extends StatefulWidget {
  const Taskbar({Key? key}) : super(key: key);

  @override
  State<Taskbar> createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1000),
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Handle home button click
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Handle browse button click
              },
            ),
            FloatingActionButton(
              onPressed: () {
                // Handle sell button click
              },
              child: const Icon(Icons.add),
              backgroundColor: Color(0xFF5C795B),
            ),
            IconButton(
              icon: const Icon(Icons.group),
              onPressed: () {
                // Handle community button click
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Handle profile button click
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
