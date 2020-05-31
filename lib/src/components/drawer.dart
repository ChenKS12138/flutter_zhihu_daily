import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "zhihu daily",
                style: TextStyle(fontSize: 27),
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
