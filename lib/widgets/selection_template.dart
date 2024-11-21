import 'package:flutter/material.dart';

class SelectionTemplate extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<Widget> buttons;

  const SelectionTemplate({
    super.key,
    required this.title,
    required this.imagePath,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    imagePath,
                    width: 370,
                    height: 300,
                  ),
                ),
                ...buttons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
