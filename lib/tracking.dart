import 'package:flutter/material.dart';

class Tracking extends StatefulWidget {
  static const String id = 'tracking';
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tracking', style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
    );
  }
}
