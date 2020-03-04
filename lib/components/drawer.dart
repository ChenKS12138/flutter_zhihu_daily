import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
              ),
            ),
            DrawerItem(text: '首页', routeName: 'index'),
            DrawerItem(text: '关于', routeName: 'about')
          ],
        ),
      );
}

class DrawerItem extends StatelessWidget {
  final String text;
  final String routeName;
  static const TextStyle style = TextStyle(fontSize: 22);
  DrawerItem({@required this.text, @required this.routeName});
  @override
  build(BuildContext context) => ListTile(
        title: Text(
          text,
          style: style,
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      );
}
