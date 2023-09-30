import 'package:flutter/material.dart';
import 'package:frontend/pages/camera.dart';
import 'package:frontend/pages/item_screen.dart';
import 'package:frontend/pages/listing.dart';
import 'package:frontend/pages/widgets/taskbar.dart';

//this code is to test and run pages from the page itself
void main() => runApp(HomeTest());

class HomeTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C795B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Add navigation logic as needed
          },
        ),
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Stack(children: [
        ListView(children: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.group),
            label: Text('ItemScreen Test'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ItemDetailsScreen(),
                ),
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.camera),
            label: Text('Camera Test'),
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              await CameraManager.instance.init();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CameraApp(),
                ),
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.propane_rounded),
            label: Text('Product Listings Test'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Listings(),
                ),
              );
            },
          )
        ]),
        const Positioned(bottom: 0, left: 0, right: 0, child: Taskbar())
      ]),
    ));
  }
}
