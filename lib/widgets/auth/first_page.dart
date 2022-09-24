import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.passwordController,
    required this.confirmpasswordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController passwordController;
  final TextEditingController confirmpasswordController;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.nameController,
            hintText: 'Full Name',
            icon: Iconsax.profile_circle,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.emailController,
            hintText: 'Email',
            icon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomTextField(
            controller: widget.phoneController,
            icon: Iconsax.call,
            hintText: 'Phone number',
            keyboardType: TextInputType.number,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.addressController,
            icon: Iconsax.location,
            hintText: 'Address',
            keyboardType: TextInputType.streetAddress,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.passwordController,
            icon: Iconsax.password_check,
            hintText: 'Password',
            isSecureText: true,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.confirmpasswordController,
            icon: Iconsax.password_check5,
            hintText: 'Confirm password',
            isSecureText: true,
            borderType: 'full',
          ),
        ),
      ],
    );
  }
}
