import 'package:flutter/material.dart';
import 'package:frontend/showallsearchbar.dart';


class ProductSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const ProductSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon:  Icon(
          Icons.search,
          color: Colors.black45,
          size: 32,
        ),
        hintText: 'Search for a product',
        hintStyle:  TextStyle(
          color: Colors.black54,
          fontSize: 17,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding:  EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onChanged: (value) {
        // Handle the text input changes
        print("Text input changed: $value");
        // Add your custom logic here, e.g., filter search results
      },
      onSubmitted: (value) {
        // Handle the text input when submitted
         Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return (NamePage(name:value));
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                ),
              );
        // Add your custom logic here, e.g., initiate search
      },
    );
  }
}
