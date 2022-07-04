import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
    required this.pickCitizen,
    required this.pickLicense,
    required this.pickBluebook,
    required this.citizenship,
    required this.bluebook,
    required this.license,
  }) : super(key: key);

  final VoidCallback pickCitizen;
  final VoidCallback pickLicense;
  final VoidCallback pickBluebook;
  final XFile? citizenship;
  final XFile? license;
  final XFile? bluebook;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Widget _handlePreview(XFile? type, String typeText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: type != null ? 500 : 200,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Center(
        child: type != null
            ? Image.file(File(type.path))
            : Text("Add $typeText Image"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            widget.pickCitizen();
          },
          child: _handlePreview(widget.citizenship, "Citizenship"),
        ),
        GestureDetector(
          onTap: () {
            widget.pickLicense();
          },
          child: _handlePreview(widget.license, "License"),
        ),
        GestureDetector(
          onTap: () {
            widget.pickBluebook();
          },
          child: _handlePreview(widget.bluebook, "Bluebook"),
        ),
      ],
    );
  }
}
