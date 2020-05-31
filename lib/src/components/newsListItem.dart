import 'package:flutter/material.dart';

import '../model/newsList.dart';

class NewsListItem extends StatelessWidget {
  final ZhDailyNewsIntro intro;
  NewsListItem({@required this.intro});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    intro?.title ?? "暂无标题",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(intro?.hint ?? "暂无hint",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ],
              ),
              flex: 7,
            ),
            Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                      image: NetworkImage(intro?.image ?? ""),
                      width: 80,
                      height: 80)),
              flex: 3,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
      ),
      onTap: () {
        Navigator.of(context).pushNamed('detail', arguments: {"id": intro.id});
      },
    );
  }
}
