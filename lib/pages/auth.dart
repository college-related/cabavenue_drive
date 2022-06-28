// ignore_for_file: unnecessary_const

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthClass extends StatefulWidget {
  const AuthClass({Key? key}) : super(key: key);

  @override
  State<AuthClass> createState() => _AuthClassState();
}

class _AuthClassState extends State<AuthClass> {
  bool isSignup = true;
  callback(){
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignup? SignupScreen(callback: callback,): LoginScreen(callback: callback,);
  }
}

// --------------------------Signup Page----------------------------
class SignupScreen extends StatefulWidget {
  const SignupScreen( {Key? key, required this.callback}) : super(key: key);
  final Function callback;
  
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isFirstScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:const EdgeInsets.symmetric( horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
              Container(
                margin: const EdgeInsets.all(10),
                child: RichText(
                  text:  TextSpan(
                    children: [
                      const TextSpan(text: 'Enter your Name, Email, Phone number, Documents photo and Password for sign up.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300,color: Colors.grey)),
                      TextSpan(text: 'Already have account?',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.callback();
                        }
                      ),
                    ]
                  ),
                ),
              ),
              isFirstScreen?const FirstPage():const SecondScreen(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 125,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        side: const BorderSide(color: Colors.blue),
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                      ),
                      onPressed: (){
                        setState((){
                          isFirstScreen = !isFirstScreen;
                        });
                      },
                      child: Row( 
                        children:const [
                          Text('Next',style: TextStyle(fontSize: 18),),
                          Icon(Icons.arrow_forward, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

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
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.account_circle_rounded, color: Colors.blue,),
              labelText: 'Enter your full name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.email_rounded, color: Colors.blue,),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Phone number',
              icon: Icon(Icons.call_rounded, color: Colors.blue,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.call_outlined, color: Colors.blue,),
              labelText: 'Secondary phone number',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              icon: Icon(Icons.location_on_rounded, color: Colors.blue,),
              labelText: 'Address',
            ),
          ),
        ),
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        margin:const EdgeInsets.symmetric( horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.lock_rounded, color: Colors.blue,),
                      labelText: 'Enter password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.lock_outline, color: Colors.blue,),
                      labelText: 'Confirm password',
                    ),
                  ),
                ),
                
              ],
            )
          ],
        ),
      );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key,required this.callback}) : super(key: key);
  final Function callback;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/images/location-style-1-rounded.jpg')),
              const Text('Cabavenue', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),),
              const Text('Welcome back!'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phone number',
                    icon: Icon(Icons.call_rounded, color: Colors.blue,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: Icon(Icons.lock_rounded, color: Colors.blue,),
                    labelText: 'Enter password',
                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.symmetric(vertical: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    side: const BorderSide(color: Colors.blue),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                    elevation: 10,
                  ),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/auth');
                  },
                  child: const Text('Login',style: TextStyle(fontSize: 20),),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle:const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(color: Colors.black54,fontSize: 16),
                    ),
                    TextSpan(
                      text: 'Register',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.callback();
                        }
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}