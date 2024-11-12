import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LinkText({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
