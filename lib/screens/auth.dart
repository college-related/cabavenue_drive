import 'dart:developer';

import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/auth_service.dart';
import 'package:cabavenue_drive/widgets/auth/first_page.dart';
import 'package:cabavenue_drive/widgets/auth/second_page.dart';
import 'package:cabavenue_drive/widgets/auth/thrid_page.dart';
import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = false;
  callback() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignup
        ? SignupScreen(
            callback: callback,
          )
        : LoginScreen(
            callback: callback,
          );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.callback}) : super(key: key);
  final Function callback;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();

  final AuthService _authService = AuthService();

  XFile? citizenship;
  XFile? license;
  XFile? bluebook;
  List<XFile?> images = [];

  final ImagePicker _imagePicker = ImagePicker();

  int screenNumber = 1;

  void pickCitizen() async {
    XFile? citizenImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      citizenship = citizenImage;
    });
  }

  void pickLicense() async {
    XFile? licenseImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      license = licenseImage;
    });
  }

  void pickBluebook() async {
    XFile? bluebookImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      bluebook = bluebookImage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _confirmPasswordController.dispose();
    _colorController.dispose();
    _modelController.dispose();
    _plateController.dispose();
  }

  void signup() {
    if (_passwordController.text == _confirmPasswordController.text) {
      _authService.signupDriver(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        password: _passwordController.text,
        color: _colorController.text,
        model: _modelController.text,
        plateNumber: _plateController.text,
        citizenship: citizenship,
        license: license,
        bluebook: bluebook,
        context: context,
      );
    } else {
      showSnackBar(context, 'Password not matched', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                const Image(
                    image: AssetImage(
                        'assets/images/location-style-1-rounded.jpg')),
                const Text(
                  'Cabavenue',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
                const Text('Start of a new journey'),
                GestureDetector(
                  onTap: () {
                    widget.callback();
                  },
                  child: const Text('Already have an account? Log in'),
                ),
                Form(
                  key: _signupFormKey,
                  child: screenNumber == 1
                      ? FirstPage(
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          phoneController: _phoneController,
                          confirmpasswordController: _confirmPasswordController,
                          addressController: _addressController,
                        )
                      : screenNumber == 2
                          ? SecondScreen(
                              colorContoller: _colorController,
                              modelController: _modelController,
                              plateController: _plateController,
                            )
                          : ThirdScreen(
                              pickCitizen: pickCitizen,
                              pickLicense: pickLicense,
                              pickBluebook: pickBluebook,
                              citizenship: citizenship,
                              bluebook: bluebook,
                              license: license,
                            ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: screenNumber == 1
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: screenNumber == 1
                              ? Colors.teal
                              : Colors.blueAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                        ),
                        onPressed: () {
                          setState(() {
                            if (screenNumber == 1) {
                              screenNumber += 1;
                            } else {
                              screenNumber -= 1;
                            }
                          });
                        },
                        child: screenNumber == 1
                            ? const Text(
                                'Continue',
                                style: TextStyle(fontSize: 16),
                              )
                            : const Text(
                                'Back',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                      screenNumber != 1
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 30,
                                ),
                              ),
                              onPressed: () {
                                if (screenNumber == 3) {
                                  if (_signupFormKey.currentState!.validate()) {
                                    signup();
                                  }
                                } else {
                                  setState(() {
                                    screenNumber += 1;
                                  });
                                }
                              },
                              child: Text(
                                screenNumber == 3 ? 'Sign up' : 'Continue',
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.callback}) : super(key: key);
  final Function callback;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  void login() {
    _authService.loginDriver(
      context: context,
      phone: _phonecontroller.text,
      password: _passwordcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  const Image(
                      image: AssetImage(
                          'assets/images/location-style-1-rounded.jpg')),
                  const Text(
                    'Cabavenue',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                  const Text('Welcome back time for more rides!'),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _phonecontroller,
                      hintText: 'Phone number',
                      icon: Iconsax.call,
                      keyboardType: TextInputType.number,
                      borderType: 'full',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _passwordcontroller,
                      hintText: 'Password',
                      icon: Iconsax.password_check,
                      isSecureText: true,
                      borderType: 'full',
                    ),
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
                        if (_loginFormKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: const Text('Log in'),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle:
                          const TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.callback();
                          }),
                  ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
