import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'body.dart';
import 'package:frontend/pages/profile.dart';


var URL =
    'http://10.0.2.2:8080/api/v1'; //replace this with ur local ip / lan ip for devices connecting on same lan / server ip if hosted
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NTUMart',
      home: ProfileScreen(),

    );
  }
}

/*
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    routes: (context)
    //home:Products(),
  ));
}
*/

/*
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  List<Product> products = [
    Product('profilepic.png', 'Used Shoes', 30.5),
    Product('profilepic.png', 'Used Shoes', 30.5),
    Product('profilepic.png', 'Used Shoes', 30.5)
  ];

  Widget productList(product){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              product.name,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height:10.0),
            Text(
              product.price.toString(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: products.map((product) => productList(product)).toList(),//Text('${product.imageURL} | ${product.name} | ${product.price}')).toList(),

      ),
    );
  }
}
*/

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('NTUMart'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: Body(),
      bottomNavigationBar: BottomAppBar(
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
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}




// psuedocode for main() jwt token
// check local storage/cookies for jwt token
// if found: navigate to home page
// else: login page
