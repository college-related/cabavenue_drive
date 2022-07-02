import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderType = 'full',
    this.isSecureText = false,
    this.colors = Colors.blueAccent,
  }) : super(key: key);

  final bool isSecureText;
  final TextEditingController controller;
  final Color colors;
  final IconData icon;
  final String borderType;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: colors,
        ),
        border: borderType == 'full'
            ? const OutlineInputBorder()
            : const UnderlineInputBorder(),
        labelText: hintText,
      ),
      obscureText: isSecureText,
      keyboardType: keyboardType,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
