import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderType = 'full',
    this.isSecureText = false,
    this.colors = Colors.grey,
  }) : super(key: key);

  final bool isSecureText;
  final TextEditingController controller;
  final Color colors;
  final IconData icon;
  final String borderType;
  final String hintText;
  final TextInputType keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(47, 96, 125, 139),
        isDense: true,
        prefixIcon: Icon(
          widget.icon,
          color: widget.colors,
        ),
        suffixIcon: widget.isSecureText
            ? IconButton(
                icon: Icon(isHidden ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
              )
            : const SizedBox(height: 0, width: 0),
        border: widget.borderType == 'full'
            ? const OutlineInputBorder()
            : const UnderlineInputBorder(),
        labelText: widget.hintText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.blueAccent,
        ),
      ),
      obscureText: (isHidden && widget.isSecureText),
      keyboardType: widget.keyboardType,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
