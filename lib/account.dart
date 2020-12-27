import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  static const String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account', style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
    );
  }
}
