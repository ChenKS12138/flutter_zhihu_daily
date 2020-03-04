import 'package:flutter/material.dart';
import 'package:zhihu_daily/model/newsList.dart';
import '../api/api.dart';
import '../components/newsListItem.dart';
import '../components/drawer.dart';

class Index extends StatefulWidget {
  static const String routeName = 'index';
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> {
  List<ZhDailyNewsList> newsListsBefore;
  ZhDailyNewsList newsListToday;
  List<ZhDailyNewsIntro> get stories =>
      (newsListToday?.stories ?? []) +
      (newsListsBefore?.fold(List<ZhDailyNewsIntro>(),
              (prev, current) => prev + current.stories) ??
          []);

  @override
  void initState() {
    // 获取以往stories
    final DateTime now = DateTime.now();
    List backDays = [0, 1, 2];
    Future.wait(backDays
            .map((backDay) =>
                Api.getNewsList(time: now.add(Duration(days: -backDay))))
            .toList())
        .then((res) {
      res.sort((a, b) => a.date.isBefore(b.date) ? 1 : 0);
      this.setState(() {
        this.newsListsBefore = res;
      });
    });
    // 获取今日stories
    Api.getNewsListNow().then((res) {
      setState(() {
        this.newsListToday = res;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: ListView(
          children: stories.length == 0
              ? [
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
                ]
              : stories
                  .map((item) => NewsListItem(
                        intro: item,
                      ))
                  .toList()),
      drawer: MyDrawer(),
    );
  }
}
