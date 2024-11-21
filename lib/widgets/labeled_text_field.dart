import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? prefixText;

  const LabeledTextField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixText: prefixText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
