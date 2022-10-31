import 'package:cabavenue_drive/helpers/snackbar.dart';
import 'package:cabavenue_drive/services/auth_service.dart';
import 'package:cabavenue_drive/widgets/auth/first_page.dart';
import 'package:cabavenue_drive/widgets/auth/second_page.dart';
import 'package:cabavenue_drive/widgets/auth/thrid_page.dart';
import 'package:cabavenue_drive/widgets/custom_text_field.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController _areaIDController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController();

  final AuthService _authService = AuthService();

  final cloudinary = Cloudinary.full(
    apiKey: dotenv.env['IMAGE_API_KEY'] ?? '',
    apiSecret: dotenv.env['IMAGE_API_SECRET'] ?? '',
    cloudName: dotenv.env['IMAGE_CLOUD_NAME'] ?? '',
  );

  XFile? citizenship;
  XFile? license;
  XFile? bluebook;
  XFile? profile;
  List<XFile?> images = [];
  List<String> imageUrls = [];
  String profileUrl = '';

  final ImagePicker _imagePicker = ImagePicker();

  int screenNumber = 1;
  bool _hasPasswordDiffError = false;

  void upload({XFile? image, bool isProfile = false}) async {
    try {
      Fluttertoast.showToast(
        msg: 'Uploading....',
        backgroundColor: Colors.orange[700],
      );

      final cloudinaryResource = CloudinaryUploadResource(
        filePath: image?.path,
        uploadPreset: '',
      );
      CloudinaryResponse response =
          await cloudinary.uploadResource(cloudinaryResource);

      if (response.isSuccessful && response.secureUrl!.isNotEmpty) {
        if (!isProfile) {
          imageUrls.add(response.secureUrl!);
        } else {
          profileUrl = response.secureUrl!;
        }
        Fluttertoast.showToast(
          msg: 'Upload complete',
          backgroundColor: Colors.green[700],
        );
      } else {
        Fluttertoast.showToast(
            msg: 'Error uploading', backgroundColor: Colors.red[600]);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: Colors.red[600]);
    }
  }

  void pickCitizen() async {
    XFile? citizenImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (citizenImage != null) {
      upload(image: citizenImage);
      setState(() {
        citizenship = citizenImage;
      });
    }
  }

  void pickLicense() async {
    XFile? licenseImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (licenseImage != null) {
      upload(image: licenseImage);
      setState(() {
        license = licenseImage;
      });
    }
  }

  void pickBluebook() async {
    XFile? bluebookImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (bluebookImage != null) {
      upload(image: bluebookImage);
      setState(() {
        bluebook = bluebookImage;
      });
    }
  }

  void pickProfile() async {
    XFile? profileImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      upload(image: profileImage, isProfile: true);
      setState(() {
        profile = profileImage;
      });
    }
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
    _areaIDController.dispose();
    _areaNameController.dispose();
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
        context: context,
        areaId: _areaIDController.text,
        areaName: _areaNameController.text,
        documents: imageUrls,
        profileUrl: profileUrl,
      );
    } else {
      setState(() {
        screenNumber = 1;
      });
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
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account?  ',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.callback();
                            }),
                    ],
                  ),
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
                          hasPassError: _hasPasswordDiffError,
                        )
                      : screenNumber == 2
                          ? SecondScreen(
                              colorContoller: _colorController,
                              modelController: _modelController,
                              plateController: _plateController,
                              areaIDController: _areaIDController,
                              areaNameController: _areaNameController,
                            )
                          : ThirdScreen(
                              pickCitizen: pickCitizen,
                              pickLicense: pickLicense,
                              pickBluebook: pickBluebook,
                              pickProfile: pickProfile,
                              citizenship: citizenship,
                              bluebook: bluebook,
                              license: license,
                              profile: profile,
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
                              if (_signupFormKey.currentState!.validate()) {
                                if (_passwordController.text ==
                                    _confirmPasswordController.text) {
                                  screenNumber += 1;
                                  _hasPasswordDiffError = false;
                                } else {
                                  _hasPasswordDiffError = true;
                                }
                              }
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
                                if (_signupFormKey.currentState!.validate()) {
                                  if (screenNumber == 3) {
                                    if (bluebook?.path != null &&
                                        license?.path != null &&
                                        citizenship?.path != null) {
                                      signup();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: 'Add required document first',
                                        backgroundColor: Colors.red[700],
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      screenNumber += 1;
                                    });
                                  }
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
                  CustomTextField(
                    controller: _phonecontroller,
                    hintText: 'Phone number',
                    icon: Iconsax.call,
                    keyboardType: TextInputType.number,
                    borderType: 'full',
                  ),
                  CustomTextField(
                    controller: _passwordcontroller,
                    hintText: 'Password',
                    icon: Iconsax.password_check,
                    isSecureText: true,
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
                        if (_loginFormKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: const Text('Log in'),
                    ),
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
