import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../components/drawer.dart';

class About extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[Text("test")],
      ),
    );
  }
}
