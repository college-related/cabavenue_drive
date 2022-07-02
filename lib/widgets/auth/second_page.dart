import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  SecondScreen({
    Key? key,
    required this.citizenship,
    required this.bluebook,
    required this.license,
  }) : super(key: key);

  String citizenship;
  String license;
  String bluebook;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void pickCitizen() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        widget.citizenship = file.toString();
      });
    }
  }

  void pickLicense() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        widget.license = file.toString();
      });
    }
  }

  void pickBluebook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        widget.bluebook = file.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  pickCitizen();
                },
                child: const Text('Upload Citizenship'),
              ),
              ElevatedButton(
                onPressed: () {
                  pickBluebook();
                },
                child: const Text('Upload License'),
              ),
              ElevatedButton(
                onPressed: () {
                  pickBluebook();
                },
                child: const Text('Upload Bluebook'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
