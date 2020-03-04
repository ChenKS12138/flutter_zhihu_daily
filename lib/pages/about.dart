import 'package:flutter/material.dart';
import '../components/drawer.dart';

class About extends StatelessWidget {
  static const String routeName = 'about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      drawer: MyDrawer(),
      body: Text('关于'),
    );
  }
}
