import 'package:flutter/material.dart';
import 'categorymapping.dart';

//CategoryButton(
//   selectedString: 'String1',
//   imageAssetPath: categoryNameToImage['String1'] ?? '', // Provide a default image path or handle missing data as needed
// )

class CategoryButton extends StatelessWidget {
  final String selectedString;
  final String imageAssetPath;

  const CategoryButton({
    super.key,
    required this.selectedString,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                Text("Add in custom category navigation later"),
                duration: Duration(milliseconds: 1500),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            fixedSize: const Size(80, 80),
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFFFFFFFF),
          ),
          child: Image.asset(imageAssetPath,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(
            selectedString,
            textScaleFactor: 1.15,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF5D7395)),
          ),
        ),
      ],
    );
  }
}