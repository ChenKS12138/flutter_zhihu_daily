import 'package:flutter/material.dart';

class DateLine extends StatelessWidget {
  DateLine({Key key, this.time}) : super(key: key);

  final DateTime time;
  String get month => this.time.month.toString();
  String get day => this.time.day.toString();

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black54;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${this.month} 月 ${this.day} 日",
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            child: Divider(
              color: color,
              thickness: 1,
            ),
            width: MediaQuery.of(context).size.width - 130,
            padding: EdgeInsets.only(left: 20),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
    );
  }
}
