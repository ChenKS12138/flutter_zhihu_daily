import 'package:flutter/material.dart';

import '../api/api.dart';
import '../components/dateLine.dart';
import '../components/drawer.dart';
import '../components/loading.dart';
import '../components/newsListItem.dart';
import '../model/newsList.dart';

class Index extends StatefulWidget {
  static const String routeName = 'index';
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> {
  // 以往的每日的新闻列表
  List<ZhDailyNewsList> newsListsBefore = List();

  // 今日的新闻列表
  //  ZhDailyNewsList newsListToday;

  // 所有的新闻列表
  List<ZhDailyNewsList> get newsLists =>
      List.from(newsListsBefore ?? [])..removeWhere((x) => x == null);

  // 往前的日期
  int backDays = 0;

  // 加载锁
  bool loadLock = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    appendNewsListBefore();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        appendNewsListBefore();
      }
    });
  }

  void appendNewsListBefore() {
    if (loadLock) return;
    loadLock = true;
    final DateTime now = DateTime.now();
    Api.getNewsList(time: now.add(Duration(days: -(backDays++))))
        .then((result) {
      newsListsBefore.add(result);
      setState(() {
        newsListsBefore = newsListsBefore;
        loadLock = false;
      });
    }).catchError((error) {
      print(error);
      loadLock = false;
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
    if (newsLists.length == 0) {
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
      controller: scrollController,
    ));
  }
}
