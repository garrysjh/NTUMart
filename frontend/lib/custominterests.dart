import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/interestmodel.dart';
import 'homepage.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart'; 


import 'package:http/http.dart' as http;
import 'package:frontend/main.dart';

void main() {
  runApp(const CustomInterests());
}

class CustomInterests extends StatelessWidget {
  const CustomInterests({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categories of Interest',
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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5C795B),
          onPrimary: Color(0xFFEAEAEA),
          secondary: Color(0xFF5D7395),
          onSecondary: Color(0xFFEAEAEA),
          error: Color(0xFFF32424),
          onError: Color(0xFFF32424),
          background: Color(0xFFF9F9F9),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFEAEAEA),
          onSurface: Color(0xFF5C795B),
        ),
      ),
      home: const CategorySelectionPage(title: 'Category Selection Page'),
    );
  }
}

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  List<String> selectedCategories = [];
  List<String> categories = [
    "Men's Fashion",
    "Women's Fashion",
    'Footwear',
    'Books & Notes',
    'Furniture',
    'Home Decor',
    'Food Items',
    'Electronics',
    'Mobile Gadgets',
    'Services',
    'Personal Care',
    'Health & Nutrition',
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const FittedBox( //Customise your experience
            fit: BoxFit.fitWidth,
            child: Text('Customise your \nexperience', maxLines: 2, style: TextStyle( height: 1 ,fontSize: 42,fontWeight: FontWeight.w600, color: Color(0xFF5C795B),))
            ),
        const SizedBox(
          height: 15
        ),
            const FittedBox( //Customise your experience
                fit: BoxFit.fitWidth,
                child: Text(' Select up to 5 categories', maxLines: 1, style: TextStyle( color: Color(0xFF5D7395), fontSize: 20,fontStyle: FontStyle.italic,)
                )
                ),
        const SizedBox(
          height: 15
        ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  mainAxisSpacing: 15.0, // Adjust the vertical spacing
                  crossAxisSpacing: 15.0, // Adjust the horizontal spacing
                  mainAxisExtent: 40,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategories.contains(category);
                  final textColor =
                  index % 2 == 0
                      ? const Color(0xFF5C795B) //If odd, green
                      : const Color(0xFF5D7395);

                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category);
                        } else {
                          if (selectedCategories.length < 5){
                            selectedCategories.add(category);
                          }
                          else {
                            // Show a message or take action when the limit is reached
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Maximum number of categories selected!'),
                                duration: Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Adjust the corner radius
                        ),
                      ),
                      backgroundColor: isSelected
                          ? MaterialStateProperty.all(textColor)
                          : MaterialStateProperty.all(const Color(0xFFF9F9F9)), //change colour later
                    ),
                    child: Text(category,
                      style: TextStyle( color: isSelected
                          ?const Color(0xFFD9D9D9) : textColor,
                        fontWeight: FontWeight.w400,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              
            ),
            const SizedBox(
                height: 20
            ),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  if (selectedCategories.isNotEmpty){
                  Interest interest = Interest.fromArray(userId, selectedCategories);
                  insertInterest(userId, interest);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lets Go!'),
                      duration: Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                      
                    ),
                    

                    
                  );
                  Future.delayed(Duration(seconds: 3));
                  ;}
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one category!'),
                      duration: Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                      
                    ),
                    

                    
                  );
                  }
                  
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the corner radius
                    ),
                  ),
                    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF5C795B)),
                    fixedSize: MaterialStateProperty.all( const Size(double.infinity, 40.0), // Change the button height
              ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left:20.0, right:20.0),
                  child: Text('Get Started',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
              )
            ),
            const SizedBox(
                height: 15
            ),
          ],

        ),
      ),
    );
  }
}

//userId = 1 for testing purposes

Future<int> insertInterest(int userID, Interest interest) async {
  int? userID = 1 ; 
  if (await JwtTokenDecryptService.hasValidToken()){ 
    userID = await JwtTokenDecryptService.getID(); 
  }
  final url = Uri.parse('$URL/user/addinterest'); // Replace with your server URL
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userID': userID,
        'category1': interest.getCategory1,
        'category2': interest.getCategory2,
        'category3': interest.getCategory3,
        'category4': interest.getCategory4,
        'category5': interest.getCategory4
      }),
    );

    if (response.statusCode == 200) {
        return 1;
      }
  }
   catch (e) {
    print('Error: $e');
    return -1;
  }
  return 0;
}
