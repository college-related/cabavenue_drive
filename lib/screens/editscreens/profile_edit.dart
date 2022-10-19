import 'package:cabavenue_drive/models/user_model.dart';
import 'package:cabavenue_drive/providers/profile_provider.dart';
import 'package:cabavenue_drive/services/user_service.dart';
import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _brandcontroller = TextEditingController();
  final TextEditingController _colorcontroller = TextEditingController();
  final TextEditingController _platecontroller = TextEditingController();
  final _profileEditKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    UserModel user =
        Provider.of<ProfileProvider>(context, listen: false).getUserData;

    _namecontroller.text = user.name;
    _emailcontroller.text = user.email;
    _phonecontroller.text = user.phone.toString();
    _addresscontroller.text = user.address;
    _brandcontroller.text = user.vehicleData['model'].toString();
    _colorcontroller.text = user.vehicleData['color'].toString();
    _platecontroller.text = user.vehicleData['plateNumber'].toString();
  }

  @override
  void dispose() {
    super.dispose();
    _phonecontroller.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _addresscontroller.dispose();
    _brandcontroller.dispose();
    _colorcontroller.dispose();
    _platecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _profileEditKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: _namecontroller,
                    hintText: 'Name',
                    icon: Iconsax.user,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _phonecontroller,
                    hintText: 'Phone number',
                    icon: Iconsax.call,
                    keyboardType: TextInputType.number,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _emailcontroller,
                    hintText: 'Email',
                    icon: Iconsax.sms,
                    keyboardType: TextInputType.emailAddress,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _addresscontroller,
                    hintText: 'Address',
                    icon: Iconsax.location,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _brandcontroller,
                    hintText: 'Model',
                    icon: Iconsax.car,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _colorcontroller,
                    hintText: 'Color',
                    icon: Iconsax.color_swatch,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _platecontroller,
                    hintText: 'Plate number',
                    icon: Iconsax.money,
                    borderType: 'full',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(8.0),
                      ),
                      onPressed: () {
                        if (_profileEditKey.currentState!.validate()) {
                          setState(() {
                            _userService.editProfile(
                                name: _namecontroller.text,
                                email: _emailcontroller.text,
                                phone: _phonecontroller.text,
                                address: _addresscontroller.text,
                                plateNumber: _platecontroller.text,
                                model: _brandcontroller.text,
                                color: _colorcontroller.text,
                                context: context);
                          });
                        }
                      },
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
