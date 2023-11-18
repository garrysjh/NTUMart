import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/onboarding.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:shared_preferences/shared_preferences.dart';
var URL = 'http://10.0.2.2:8080/api/v1'; //replace this with ur local ip / lan ip for devices connecting on same lan / server ip if hosted
int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = (await prefs.getInt("initScreen"))!;
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
  if (await JwtTokenDecryptService.hasValidToken()) {
    runApp(const Home());
  }
  else{ 
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NTUMart',
      initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
      routes: {
        '/': (context) => LoginPage(),
        "first": (context) => OnBoardingScreen(), //change to onboarding screen
      },
    );
  }
}

// psuedocode for main() jwt token
// check local storage/cookies for jwt token
// if found: navigate to home page
// else: login page
