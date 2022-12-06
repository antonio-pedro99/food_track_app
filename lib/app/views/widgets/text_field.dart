import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.hint,
      this.icon = Icons.search});

  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
