import 'package:flutter/material.dart';
import 'package:frontend/models/listingmodel.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;


//this code is to test and run pages from the page itself
void main() {
  runApp(const ListingsTest());
}

class ListingsTest extends StatelessWidget {
  const ListingsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Listings());
  }
}

Future<List<Listing>> fetchListings() async {
  final url = Uri.parse('$URL/product/listing');
  final response = await http.get(url);

  return parseListings(response.body);
}

class Listings extends StatefulWidget {
  const Listings({super.key});

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    super.initState();
  }

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
            body: FutureBuilder<List<Listing>>(
                future: fetchListings(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return const Text('No data available.');
                  } else {
                    List<Listing> allListings = snapshot.data;
                    List<Widget> listingWidgets = [];
                    for (Listing listing in allListings) {
                      String filePath = listing.getProductPic();
                      print(filePath);
                      listingWidgets.add(ListTile(title: Text(filePath)));
                    }
                    return Stack(children: [
                      ListView(children: listingWidgets),
                      const Positioned(
                          bottom: 0, left: 0, right: 0, child: Taskbar())
                    ]);
                  }
                })));
  }
}
