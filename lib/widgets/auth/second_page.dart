import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.modelController,
    required this.colorContoller,
    required this.plateController,
  }) : super(key: key);

  final TextEditingController modelController;
  final TextEditingController colorContoller;
  final TextEditingController plateController;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.modelController,
            hintText: 'Vehicle Model: Maruti, Hudson',
            icon: Iconsax.car,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: widget.colorContoller,
            hintText: 'Color: red, white',
            icon: Iconsax.color_swatch,
            keyboardType: TextInputType.emailAddress,
            borderType: 'full',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomTextField(
            controller: widget.plateController,
            icon: Iconsax.money,
            hintText: 'Plate Number: Ga 10 Pa 1111',
            borderType: 'full',
          ),
        ),
      ],
    );
  }
}
