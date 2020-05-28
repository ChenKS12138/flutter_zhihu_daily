import 'package:flutter/material.dart';

import './src/routes/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZhihuDaily',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'index',
      routes: myRoute,
    );
  }
}
