import 'package:cabavenue_drive/helpers/validator.dart';
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
    this.validations = const [],
    this.length = 8,
    this.hasError = false,
    this.errorMessage = '',
    this.focusNode,
    this.onTap,
  }) : super(key: key);

  final bool isSecureText;
  final TextEditingController controller;
  final Color colors;
  final IconData icon;
  final String borderType;
  final String hintText;
  final TextInputType keyboardType;
  final List<String> validations;
  final int length;
  final bool hasError;
  final String errorMessage;
  final FocusNode? focusNode;
  final Function? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: widget.onTap != null
            ? () {
                widget.onTap!();
              }
            : null,
        focusNode: widget.focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        decoration: InputDecoration(
          errorText: widget.hasError ? widget.errorMessage : null,
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
        ),
        obscureText: (isHidden && widget.isSecureText),
        keyboardType: widget.keyboardType,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your ${widget.hintText}';
          }
          var validation = validator(
            validations: widget.validations,
            value: val,
            length: widget.length,
          );
          if (!validation['isValidate']) {
            return validation['message'];
          }
          return null;
        },
      ),
    );
  }
}
