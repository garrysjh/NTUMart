import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: const Row(
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            SizedBox(
              width: 16,
            ),
            Text("An error occured while loading stories.")
          ],
        ),
      ),
    );
  }
}