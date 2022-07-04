import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/auth_service.dart';
import 'package:cabavenue_drive/widgets/auth/first_page.dart';
import 'package:cabavenue_drive/widgets/auth/second_page.dart';
import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = true;
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
  bool isFirstScreen = true;
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _secondaryphoneController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  XFile? citizenship;
  XFile? license;
  XFile? bluebook;
  List<XFile?> images = [];

  final ImagePicker _imagePicker = ImagePicker();

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
    _secondaryphoneController.dispose();
    _addressController.dispose();
    _confirmPasswordController.dispose();
  }

  void signup() {
    if (_passwordController.text == _confirmPasswordController.text) {
      _authService.signupDriver(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        secondaryphone: _secondaryphoneController.text,
        address: _addressController.text,
        password: _passwordController.text,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text:
                            'Enter your Name, Email, Phone number, Documents photo and Password for sign up.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                    TextSpan(
                        text: 'Already have account?',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.callback();
                          }),
                  ]),
                ),
              ),
              Form(
                key: _signupFormKey,
                child: isFirstScreen
                    ? FirstPage(
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        phoneController: _phoneController,
                        confirmpasswordController: _confirmPasswordController,
                        addressController: _addressController,
                        secondaryphoneController: _secondaryphoneController,
                      )
                    : SecondScreen(
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
                  mainAxisAlignment: isFirstScreen
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 125,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          side: const BorderSide(color: Colors.blue),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                        ),
                        onPressed: () {
                          setState(() {
                            isFirstScreen = !isFirstScreen;
                          });
                        },
                        child: isFirstScreen
                            ? Row(
                                children: const [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.blue,
                                  ),
                                ],
                              )
                            : Row(
                                children: const [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    !isFirstScreen
                        ? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              side: const BorderSide(
                                color: Colors.blue,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 30,
                              ),
                            ),
                            onPressed: () {
                              if (_signupFormKey.currentState!.validate()) {
                                signup();
                              }
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20),
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Column(
                children: [
                  const Image(
                      image: AssetImage(
                          'assets/images/location-style-1-rounded.jpg')),
                  const Text(
                    'Cabavenue',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                  const Text('Welcome back!'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _phonecontroller,
                      hintText: 'Phone number',
                      icon: Icons.call_rounded,
                      keyboardType: TextInputType.number,
                      borderType: 'under;ine',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _passwordcontroller,
                      hintText: 'Password',
                      icon: Icons.lock_rounded,
                      isSecureText: true,
                      borderType: 'underline',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        side: const BorderSide(color: Colors.blue),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80),
                        elevation: 10,
                      ),
                      onPressed: () {
                        login();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
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
                      text: 'Don\'t have an account?',
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
        ));
  }
}
