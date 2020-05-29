import 'package:flutter/material.dart';

import '../components/newsListItem.dart';
import '../api/api.dart';
import '../components/dateLine.dart';
import '../components/drawer.dart';
import '../components/loading.dart';
import '../model/newsList.dart';

class Index extends StatefulWidget {
  static const String routeName = 'index';
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> {
  // 以往的每日的新闻列表
  List<ZhDailyNewsList> newsListsBefore;

  // 今日的新闻列表
  ZhDailyNewsList newsListToday;

  // 所有的新闻列表
  List<ZhDailyNewsIntro> get stories =>
      (newsListToday?.stories ?? []) +
      (newsListsBefore?.fold(List<ZhDailyNewsIntro>(),
              (prev, current) => prev + current.stories) ??
          []);

  List<ZhDailyNewsList> get newsLists => List.from(newsListsBefore ?? [])
    ..add(newsListToday)
    ..removeWhere((x) => x == null);

  // 往前的日期
  List backDays = [0, 1, 2];

  @override
  void initState() {
    super.initState();
    this.fetchNewsListBefore();
    // 获取今日stories
    Api.getNewsListNow().then((res) {
      setState(() {
        this.newsListToday = res;
      });
    });
  }

  void fetchNewsListBefore() {
    // 获取以往stories
    final DateTime now = DateTime.now();
    Future.wait(this
            .backDays
            .map((backDay) =>
                Api.getNewsList(time: now.add(Duration(days: -backDay))))
            .toList())
        .then((res) {
      res.sort((a, b) => a.date.isBefore(b.date) ? 1 : 0);
      this.setState(() {
        this.newsListsBefore = res;
      });
    });
  }

  Widget render(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      drawer: MyDrawer(),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 显示loading
    if (newsListToday == null && newsListsBefore == null) {
      return render(Container(
        child: Loading(),
        alignment: Alignment.center,
      ));
    }
    return render(ListView(
      children: newsLists
          .map((list) {
            return [
              DateLine(
                time: list.date,
              ),
              ...list.stories
                  .map((story) => NewsListItem(
                        intro: story,
                      ))
                  .toList()
            ];
          })
          .fold(List<Widget>(), (prev, current) => prev + current)
          .toList(),
    ));
  }
}
