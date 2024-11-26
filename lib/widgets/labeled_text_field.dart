import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? prefixText;
  final int maxLines;
  final Color labelColor;
  final bool enabled;
  final Widget? prefixIcon;

  const LabeledTextField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.prefixText,
    this.maxLines = 1,
    this.labelColor = Colors.black,
    this.enabled = true,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: labelColor),
        ),
        const SizedBox(height: 2),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          enabled: enabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixText: prefixText,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}