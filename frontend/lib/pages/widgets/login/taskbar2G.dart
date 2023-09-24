import 'package:flutter/material.dart';


class Taskbar extends StatefulWidget {
  const Taskbar({Key? key}) : super(key: key);

  @override
  State<Taskbar> createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar>{
  @override
  Widget build(BuildContext context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Transform.translate(
        offset: const Offset(0, 10),
        child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
          child: Transform.translate(
            offset: const Offset(0,-5),
            child:Row(children: <Widget>[
          const SizedBox(width: 20),
          Column(
              children: <Widget>[IconButton(icon: const Icon(Icons.home_outlined), iconSize: 40.0,
          onPressed:(){}), const Text('Home', style: TextStyle(
    fontSize: 15.0, // Adjust the font size as needed
  ),)]
            ),
            const Spacer(),
          Column(
              children: <Widget>[IconButton(icon: const Icon(Icons.search),  iconSize: 40.0,
          onPressed:(){}), const Text('Browse', style: TextStyle(
    fontSize: 15.0, // Adjust the font size as needed
  ),)]
            ),
            const Spacer(),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow:  [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(0, -1),
                ),
              ]),
              child: 
              IconButton(icon: const Icon(Icons.monetization_on), iconSize: 40.0, onPressed:(){}), 
            ), 
            const Spacer(),
            Column(
              children: <Widget>[IconButton(icon: const Icon(Icons.people_outline), iconSize: 40.0,
          onPressed:(){}), Text('Social', style: TextStyle(
    fontSize: 15.0, // Adjust the font size as needed
  ),)]
            ), const Spacer(),
            Column(
              children: <Widget>[IconButton(icon: const Icon(Icons.person_outlined), iconSize: 40.0,
          onPressed:(){}), const Text('You', style: TextStyle(
    fontSize: 15.0, // Adjust the font size as needed
  ),)]
            ), const SizedBox(width: 20),
          
            ]
            ),)
            )
          
      ))
    );
  }
}