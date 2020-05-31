import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  // 加载锁，一次只发一个请求
  bool loadLock = false;

  // 显示回到顶部
  bool showFloatButton = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    appendNewsListBefore();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Fluttertoast.showToast(msg: "加载中...");
        appendNewsListBefore();
      }
      if (scrollController.position.pixels < 40 && showFloatButton) {
        setState(() {
          showFloatButton = false;
        });
      } else if (scrollController.position.pixels >= 40 && !showFloatButton) {
        setState(() {
          showFloatButton = true;
        });
      }
    });
  }

  void appendNewsListBefore() async {
    if (loadLock) return;
    loadLock = true;
    final DateTime now = DateTime.now();
    try {
      ZhDailyNewsList result =
          await Api.getNewsList(time: now.add(Duration(days: -(backDays++))));
      Fluttertoast.cancel();
      newsListsBefore.add(result);
      setState(() {
        newsListsBefore = newsListsBefore;
      });
    } catch (error) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: error.toString());
    } finally {
      loadLock = false;
    }
  }

  Widget render(Widget child) {
    FloatingActionButton floatButton;
    if (showFloatButton) {
      floatButton = FloatingActionButton(
        child: Image.asset(
          'lib/src/assets/icon/top.png',
          width: 25,
          height: 25,
        ),
        onPressed: () {
          scrollController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.easeOutCubic);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      drawer: MyDrawer(),
      body: child,
      floatingActionButton: floatButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
