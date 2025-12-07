import 'package:chessy/home.dart';
import 'package:chessy/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: MainPage(duration: 'aa'),
      ),
    ),
  ));
}

