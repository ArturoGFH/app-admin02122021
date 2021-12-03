import 'package:flutter/material.dart';
import 'package:project_final/Views/Login.dart';
import 'package:project_final/Views/ListUsers.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Primera App",
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        home: Login());
  }
}
