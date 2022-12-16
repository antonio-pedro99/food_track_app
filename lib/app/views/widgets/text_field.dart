import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.hint,
      this.onChanged,
      this.onEnter,
      this.onValidate,
      this.icon = Icons.search});

  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  final Function(String)? onEnter;
  final Function(String)? onChanged;
  final String? Function(String?)? onValidate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: onValidate,
        onFieldSubmitted: onEnter,
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(icon),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
