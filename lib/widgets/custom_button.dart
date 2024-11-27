import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final double textSize;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.textSize = 16.0,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          elevation: 5.0,
          shadowColor: Colors.black.withOpacity(0.5),
          animationDuration: const Duration(milliseconds: 200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
