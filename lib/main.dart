import 'package:flutter/material.dart';
import 'package:sembast_database/homepage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
      ),
      title:"impimentation of sembast database",
      home: HomePage(),
    );
  }
}