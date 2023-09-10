import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';


var URL = 'http://192.168.1.102:8080/api/v1'; //replace this with ur local ip / lan ip for devices connecting on same lan / server ip if hosted

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
      title: 'TheGorgeousLogin',
      home: LoginPage(),
    );
  }
}

// psuedocode for main() jwt token 
// check local storage/cookies for jwt token
// if found: navigate to home page
// else: login page 