import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.hint,
      this.onEnter,
      this.icon = Icons.search});

  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  final Function(String)? onEnter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        onChanged: onEnter,
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
