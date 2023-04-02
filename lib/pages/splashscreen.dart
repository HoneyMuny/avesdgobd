import 'dart:async';
import 'package:avesdgobd/pages/googleauth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder:(BuildContext context){
            return GoogleAuth();
          }
      ));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("images/medium.png"),
      ),
    );
  }
}