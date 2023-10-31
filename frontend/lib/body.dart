import 'package:flutter/material.dart';
import 'product.dart';
import 'package:frontend/pages/widgets/vertical_view_listings.dart'; 
//import 'searchBar.dart';

void main() {
  runApp( Body());
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .15,
          color: const Color(0xFF5C795B),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(255,255, 255, 1),
                  backgroundImage: AssetImage('assets/profilepic.png'),
                  radius: 40.0,
                ),
                Divider(
                  height: 35.0,
                  color: Colors.black45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Keegan Lee', //Username
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.black54,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.telegram,
                      color: Colors.black54,
                    ),
                    Text(
                      '@kiwigan', //Telegram
                      style: TextStyle(
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30.0,
                  color: Colors.black45,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Your Listings',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,15.0,8.0, 15.0),
                  child: SearchBar(
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    //constraints: BoxConstraints(),
                    leading: const Icon(Icons.search),
                    trailing: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic),
                      ),
                    ],

                    hintText: 'Search for a listing',
                  ),
                ),
                // VerticalViewListings(products: products)
              ],
            )),
      ],
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
