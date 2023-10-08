import 'package:flutter/material.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import '../body.dart';

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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('NTUMart'),
          centerTitle: true,
          backgroundColor: Colors.green[400],
        ),
        body: Stack(
          children: <Widget>[
            Body(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Taskbar(),
            )
          ],
        ));
  }
}

/*

class NinjaCard extends StatefulWidget {
  @override
  State<NinjaCard> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: const Text('NTUMart'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),

      body: const Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/profilepic.jpf'),
              radius: 40.0,
            ),
            Divider(
              height: 50.0,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                Text(
                  'Keegan Lee', //Username
                  style:TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                )

                ],
            ),
            Row(
              children:<Widget>[
                Icon(
                  Icons.telegram,
                  color: Colors.black54,
                ),
                Text(
                    '@kiwigan', //Telegram
                    style:TextStyle(
                      letterSpacing: 2.0,
                    ),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }
}

*/
