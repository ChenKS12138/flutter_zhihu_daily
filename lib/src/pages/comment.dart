import 'package:flutter/material.dart';
import 'package:zhihu_daily/src/model/newsComment.dart';

import '../api/api.dart';
import '../components/loading.dart';
import '../components/newsCommentItem.dart';

class Comment extends StatefulWidget {
  static const String routeName = 'comment';
  final int id;
  Comment({@required this.id});

  @override
  State<StatefulWidget> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  // 长评论
  ZhDailyNewsComment longComments;

  // 短评论
  ZhDailyNewsComment shortComments;

  @override
  void initState() {
    super.initState();

    Api.getNewsLongComments(id: widget.id)
        .then((result) => setState(() => longComments = result));

    Api.getNewsShortComments(id: widget.id)
        .then((result) => setState(() => shortComments = result));
  }

  Widget render(Widget child) {
    String title = "评论";

    if (longComments?.count != null &&
        shortComments?.count != null &&
        longComments.count + shortComments.count > 0) {
      title = "${longComments.count + shortComments.count}条评论";
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 显示loading
    if (longComments == null || shortComments == null) {
      return render(Container(
        child: Loading(),
        alignment: Alignment.center,
      ));
    }

    // 显示无评论
    if (longComments.count == 0 && shortComments.count == 0) {
      return render(Center(
        child: Text("暂无评论～"),
      ));
    }

    List<Widget> listViewChildren = List();

    // 显示长评论
    if (longComments.count > 0) {
      listViewChildren.add(Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
        child: Text(
          "${longComments.count}条长评论",
          style: TextStyle(fontSize: 20),
        ),
      ));
      listViewChildren
          .addAll(longComments.comments.map((comment) => NewsCommentItem(
                comment: comment,
              )));
    }

    // 显示短评论
    if (shortComments.count > 0) {
      listViewChildren.add(Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
        child: Text(
          "${shortComments.count}条短评论",
          style: TextStyle(fontSize: 20),
        ),
      ));
      listViewChildren
          .addAll(shortComments.comments.map((comment) => NewsCommentItem(
                comment: comment,
              )));
    }

    listViewChildren.add(Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
      child: Text(
        "已显示全部评论~",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ));

    return render(ListView(
      children: listViewChildren,
    ));
  }
}
