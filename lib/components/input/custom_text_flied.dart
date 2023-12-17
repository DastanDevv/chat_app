import 'package:flutter/material.dart';

class CustomTextFlied extends StatelessWidget {
  const CustomTextFlied({
    super.key,
    this.labelText,
    this.controller,
  });

  final String? labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
