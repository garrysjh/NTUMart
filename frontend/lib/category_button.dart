import 'package:flutter/material.dart';
import 'categorymapping.dart';
import 'package:frontend/showcategory.dart';

class CategoryButton extends StatelessWidget {
  final String selectedString;
  late String path;

  CategoryButton({Key? key, required this.selectedString}) {
    path = categorymapping().categoryMap[selectedString] ?? "";
  }
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content:
              //     Text("Add in custom category navigation later"),
              //     duration: Duration(milliseconds: 1500),
              //     behavior: SnackBarBehavior.floating,
              //   ),
              // );
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return CategoryPage(category: selectedString);
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 5,
              fixedSize: const Size(72, 72),
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFFFFFFF),
            ),
            child: Image.asset(this.path,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: SizedBox(
              width: 72,
              child: Text(
                selectedString,
                textScaleFactor: 1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF5D7395)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  String mapped(String str){
    categorymapping Cat = new categorymapping();
    return Cat.categoryNameToImage(str);
  }
}

