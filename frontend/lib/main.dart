import 'package:flutter/material.dart';

void main() {
  runApp(const ItemDetailsScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
          title: const Text('Item Details'),
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xFFF8F8F8),
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Slide show of item's images
                Container(
                  height: 200, // Adjust the height as needed
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




              ],
            ),
          ),
        ),
        // Bottom task bar
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
      ),
    );
  }
}
