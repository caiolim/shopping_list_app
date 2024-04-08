import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextFormFieldWidget({
    super.key,
    this.obscureText = false,
    this.label,
    this.hintText,
    this.maxLines,
    this.maxLength,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: label == null ? null : Text(label!),
        hintText: hintText,
      ),
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }
}
