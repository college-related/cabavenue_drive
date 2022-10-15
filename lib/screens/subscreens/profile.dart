import 'package:cabavenue_drive/models/user_model.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                    height: 150.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AuthService().logout(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    child: const Text('Logout'),
                  )
                ],
              ),
              const ProfileSectionTitle(title: 'Personal Details'),
              ProfileSectionBox(type: 'personal', user: profile.getUserData),
              const ProfileSectionTitle(title: 'Vehicle Details'),
              ProfileSectionBox(type: 'vehicle', user: profile.getUserData),
              const ProfileSectionTitle(title: 'Documents'),
              const DocumentSection(),
            ],
          ),
        );
      },
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
            color: Colors.black12,
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.edit),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class ProfileSectionBox extends StatefulWidget {
  const ProfileSectionBox({
    Key? key,
    required this.type,
    required this.user,
  }) : super(key: key);

  final String type;
  final UserModel user;

  @override
  State<ProfileSectionBox> createState() => _ProfileSectionBoxState();
}

class _ProfileSectionBoxState extends State<ProfileSectionBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: widget.type == 'personal'
              ? [
                  ProfileDetailRow(title: 'Name', value: widget.user.name),
                  ProfileDetailRow(
                      title: 'Phone Number',
                      value: widget.user.phone.toString()),
                  ProfileDetailRow(title: 'Email', value: widget.user.email),
                  ProfileDetailRow(
                      title: 'Address', value: widget.user.address),
                ]
              : [
                  ProfileDetailRow(
                      title: 'Brand', value: widget.user.vehicleData["model"]),
                  ProfileDetailRow(
                      title: 'Color', value: widget.user.vehicleData["color"]),
                  ProfileDetailRow(
                      title: 'Plate Number',
                      value: widget.user.vehicleData["plateNumber"]),
                ],
        ),
      ),
    );
  }

  SizedBox shimmerEffect(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white,
        child: SizedBox(
          height: 25.0,
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Text('Data loading....'),
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
      padding: const EdgeInsets.only(bottom: 20.0),
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
