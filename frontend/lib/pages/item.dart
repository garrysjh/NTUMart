import 'package:dip/widgets/taskbar.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(

        body: Container(
          color: const Color(0xFFF8F8F8),
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Slide show of item's images
                Container(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      // Replace 'assets/img' with the actual path to your images
                      return Image.asset('assets/img/product${index + 1}.jpg');
                    },
                  ),
                ),

                // Display name, quantity, and price
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: const Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Nike Air Jordan 1',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5C795B),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '\$150.00',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D7395),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0), // Add spacing between rows
                      Row(
                        children: <Widget>[
                          Text(
                            'Quantity: 1',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12.0), // Adjust the spacing as needed
                      Text(
                        "Perhaps the most iconic sneaker of all-time, this original \"Chicago\" colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the ...More",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),


                // Seller details
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3), // Set the background color
                      borderRadius: BorderRadius.circular(12.0), // Add rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 24.0, // Make the avatar smaller
                              backgroundImage: AssetImage('assets/img/avatar.jpg'),
                            ),
                            SizedBox(width: 12.0), // Increase the space between the avatar and text
                            // Bold the username
                            Text(
                              'Miyamura Izumi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0), // Increase the space between rows
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/telegram.png', height: 14.0), // Make icons smaller
                            const SizedBox(width: 12.0),
                            const Text(
                              'Telegram: @horimiya',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/whatsapp.png', height: 14.0),
                            const SizedBox(width: 12.0),
                            const Text(
                              'Phone/WhatsApp: +6512345678',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/img/dollar-symbol.png', height: 14.0),
                            const SizedBox(width: 12.0),
                            const Text(
                              'Payment methods: Cash, PayNow, Bank number',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5.0), //space between "Seller details" and "Contact seller" button
                // Contact seller button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(), // Empty container to create spacing
                      ),
                      Expanded(
                        flex: 2, // Adjust the flex value as needed
                        child: Container(
                          height: 60, // Adjust the height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle contact seller button click
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF5D7395), // Background color
                            ),
                            child: const Text(
                              'Contact Seller',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(), // Empty container to create spacing
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 20.0),




              ],
            ),
          ),
        ),
       bottomNavigationBar: const Taskbar(),
       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}