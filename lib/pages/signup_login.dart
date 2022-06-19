import 'package:flutter/material.dart';

class SignupLogin extends StatefulWidget {
  const SignupLogin({Key? key}) : super(key: key);

  @override
  State<SignupLogin> createState() => _SignupLoginState();
}

class _SignupLoginState extends State<SignupLogin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), color: Colors.black,),
      ),
      body: Container(
        margin:const EdgeInsets.symmetric( horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create Account', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500,letterSpacing: 1),),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(text: 'Enter your Name, Email, Phone number, Documents photo and Password for sign up.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300,color: Colors.grey)),
                  TextSpan(text: 'Already have account?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.blue)),
                ]
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.blue,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      contentPadding:const EdgeInsets.symmetric(vertical: 0,horizontal: 10)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}