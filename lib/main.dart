import 'package:flutter/material.dart';
import 'package:whatapps/screens/homescreens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.greenAccent,
        ),
      ),
      home: const Homescreens(),
      
    );
  }
}
