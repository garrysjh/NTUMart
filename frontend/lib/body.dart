import 'package:flutter/material.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:frontend/settings.dart'; 


class Body extends StatelessWidget {
  final FutureBuilder verticalView;
  final String username; 
  final String telegramHandle; 
  const Body({Key? key, required this.username, required this.telegramHandle, required this.verticalView}) : super(key: key);
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
                const SizedBox(height: 50),
                const CircleAvatar(
                  backgroundColor: Color.fromRGBO(255,255, 255, 1),
                  backgroundImage: AssetImage('assets/profilepic.png'),
                  radius: 40.0,
                ),
                const Divider(
                  height: 20,
                  color: Colors.black45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                     username, //Username
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      color: Colors.black54,
                      onPressed: () {
                        navigateToSettings(context); 
                      },
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
                      "@$telegramHandle" , //Telegram
                      style: TextStyle(
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.black45,
                ),
                const Row(
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
                verticalView // VerticalViewListings(products: products)
              ],
            )),
      ],
    );
  }
}

void navigateToSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>  SettingsPageWidget(), // Replace SettingsPage with your actual settings page widget
    ),
  );
}
class ProductList extends StatefulWidget {
  const ProductList({super.key});

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
