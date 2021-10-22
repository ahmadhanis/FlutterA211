import 'dart:async';

import 'package:flutter/material.dart';

import 'bmicalcpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calc',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const BmiCalcPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("SLUMBERSOFT",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          Image.asset('assets/images/bmicalc.png', scale: 2),
          const Text("Version 0.1",
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      )),
    );
  }
}
