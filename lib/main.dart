

import 'package:flutter/material.dart';

import 'homescreen.dart';

void main(){
  runApp(CrudApp());
}
class CrudApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crud App",
          theme: ThemeData(primarySwatch: Colors.lightBlue),
      darkTheme: ThemeData(primarySwatch: Colors.cyan),
      home: const HomeScreen(),
    );
  }

}

