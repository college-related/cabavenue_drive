import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.secondaryphoneController,
    required this.addressController,
    required this.passwordController,
    required this.confirmpasswordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController secondaryphoneController;
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
            icon: Icons.account_circle_rounded,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.emailController,
            hintText: 'Email',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomTextField(
            controller: widget.phoneController,
            icon: Icons.call_rounded,
            hintText: 'Phone number',
            keyboardType: TextInputType.number,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.secondaryphoneController,
            icon: Icons.call_outlined,
            hintText: 'Secondary phone number',
            keyboardType: TextInputType.number,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.addressController,
            icon: Icons.location_on_rounded,
            hintText: 'Address',
            keyboardType: TextInputType.streetAddress,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.passwordController,
            icon: Icons.lock_rounded,
            hintText: 'Password',
            isSecureText: true,
            borderType: 'underline',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.confirmpasswordController,
            icon: Icons.lock_outline,
            hintText: 'Confirm password',
            isSecureText: true,
            borderType: 'underline',
          ),
        ),
      ],
    );
  }
}
