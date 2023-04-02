import 'package:avesdgobd/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          fontFamily: "Vanilla Caramel",
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 25.0, color: Colors.white),
              bodyText2: TextStyle(fontSize: 25.0, color: Colors.black)
          )
      ),
      home: Center(
        child: SplashScreen(),
      ),
    );
  }

}