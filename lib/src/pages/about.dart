import 'package:flutter/material.dart';

import '../components/drawer.dart';

class About extends StatelessWidget {
  static const String routeName = 'about';

  Widget render(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      drawer: MyDrawer(),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return render(Container(
      width: size.width,
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset('lib/src/assets/image/ic_launcher.png'),
            padding: EdgeInsets.only(top: 30),
          ),
          Container(
            child: Text(
              "zhihu daily",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            padding: EdgeInsets.only(top: 40),
          )
        ],
      ),
    ));
  }
}
