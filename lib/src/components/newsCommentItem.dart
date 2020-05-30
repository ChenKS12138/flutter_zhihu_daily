import 'package:flutter/material.dart';

import '../model/newsComment.dart';

class NewsCommentItem extends StatelessWidget {
  final ZhDailyNewsCommentItem comment;
  NewsCommentItem({this.comment});

  convertDateText(DateTime time) =>
      "${time.month}-${time.day} ${time.hour}:${time.minute}";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage(comment.avatar),
            ),
            padding: EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  comment.author,
                ),
                Text(
                  comment.content,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      convertDateText(comment.time),
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(comment.likes.toString()),
                          Image.asset(
                            'lib/src/assets/icon/like.png',
                            height: 16,
                            width: 16,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
