
import 'package:flutter/material.dart';

import './ar.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyARApp());
}

class MyARApp extends StatelessWidget {
  const MyARApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
)),
      home: const LocalAndWebObjectsView(),
    );
  }
}
