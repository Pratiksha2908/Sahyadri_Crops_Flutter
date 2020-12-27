import 'package:flutter/material.dart';
import 'package:sahyadri_farms/account.dart';
import 'package:sahyadri_farms/dashboard.dart';
import 'package:sahyadri_farms/tracking.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'navigation';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Tracking(),
    Account(),
  ];

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: colorScheme.surface,
            selectedItemColor: colorScheme.onSurface,
            unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
            selectedLabelStyle: textTheme.caption,
            unselectedLabelStyle: textTheme.caption,
            onTap: (value) {
              // Respond to item press.
              setState(() => _currentIndex = value);
            },
            items: [
              BottomNavigationBarItem(
                title: Text('Dashboard'),
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                title: Text('Tracking'),
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                title: Text('Account'),
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}