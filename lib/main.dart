import 'package:flutter/material.dart';
import 'package:sahyadri_farms/account.dart';
import 'package:sahyadri_farms/dashboard.dart';
import 'package:sahyadri_farms/navigation_view.dart';
import 'package:sahyadri_farms/tracking.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        Dashboard.id : (context) => Dashboard(),
        Tracking.id : (context) => Tracking(),
        Account.id : (context) => Account(),
        MyHomePage.id : (context) => MyHomePage(),
      },
    );
  }
}

