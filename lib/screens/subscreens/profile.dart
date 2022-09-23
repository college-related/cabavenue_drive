import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ProfileSectionTitle(title: 'Personal Details'),
        ProfileSectionBox(type: 'personal'),
        ProfileSectionTitle(title: 'Vehicle Details'),
        ProfileSectionBox(type: 'vehicle'),
        ProfileSectionTitle(title: 'Documents'),
        DocumentSection(),
      ],
    );
  }
}

class DocumentSection extends StatelessWidget {
  const DocumentSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(127, 158, 158, 158),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('License'),
            const SizedBox(height: 20.0),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOqZtyjNtmb04lLYa3b37LViN63p9BzgO8eQ&usqp=CAU',
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            const Text('Citizenship'),
            const SizedBox(height: 20.0),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOqZtyjNtmb04lLYa3b37LViN63p9BzgO8eQ&usqp=CAU',
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            const Text('BlueBook'),
            const SizedBox(height: 20.0),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOqZtyjNtmb04lLYa3b37LViN63p9BzgO8eQ&usqp=CAU',
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSectionTitle extends StatelessWidget {
  const ProfileSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline1),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit)),
        ],
      ),
    );
  }
}

class ProfileSectionBox extends StatefulWidget {
  const ProfileSectionBox({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  State<ProfileSectionBox> createState() => _ProfileSectionBoxState();
}

class _ProfileSectionBoxState extends State<ProfileSectionBox> {
  var user;

  @override
  void initState() {
    super.initState();
    _readUserData();
  }

  Future<void> _readUserData() async {
    var u = await const FlutterSecureStorage().read(key: "CABAVENUE_USERDATA");
    setState(() {
      user = jsonEncode(u);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(127, 158, 158, 158),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: widget.type == 'personal'
              ? const [
                  ProfileDetailRow(title: 'Name', value: 'Alson Garbuja'),
                  ProfileDetailRow(title: 'Phone Number', value: '9825140214'),
                  ProfileDetailRow(title: 'Email', value: 'alson@gmail.com'),
                  ProfileDetailRow(
                      title: 'Address', value: 'Lamachour-16, pokhara'),
                ]
              : const [
                  ProfileDetailRow(title: 'Brand', value: 'Maruti'),
                  ProfileDetailRow(title: 'Color', value: 'Red'),
                  ProfileDetailRow(
                      title: 'Plate Number', value: 'Ga 11 Pa 1234'),
                ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:'),
          Text(value),
        ],
      ),
    );
  }
}
