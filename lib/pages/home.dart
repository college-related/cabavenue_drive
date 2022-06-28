import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/location-style-1-rounded.jpg')),
            const Text('Cabavenue', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),),
            // Text('Drive', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey),),
            SizedBox(
              // width: MediaQuery.of(context).size.width,
              child: Container(
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
                  child: const Text('Signup',style: TextStyle(fontSize: 20),),),
              )
            )
          ],
        ),
      )
    );
  }
}