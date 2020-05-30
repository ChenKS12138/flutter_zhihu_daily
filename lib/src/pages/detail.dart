import 'package:flutter/material.dart';

import '../api/api.dart';
import '../components/loading.dart';
import '../utils/html2widget.dart';

class Detail extends StatefulWidget {
  static const String routeName = 'detail';
  final int id;
  Detail({this.id});
  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<Detail> {
  // 文章的标题
  String title;

  // 顶部头图的url
  String headImageUrl;

  // 顶部头图的来源
  String headImageResource;

  // 富文本内容
  String htmlBody;
  @override
  void initState() {
    super.initState();
    Api.getNewsDetail(id: widget.id).then((result) {
      this.setState(() {
        this.htmlBody = result.body;
        this.title = result.title;
        this.headImageUrl = result.image;
        this.headImageResource = result.imageSource;
      });
    });
    Api.getNewsExtra(id: widget.id).then((result) {
      print(result);
    });
  }

  Widget render(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
      ),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 显示loading
    if (htmlBody == null) {
      return render(Container(
        child: Loading(),
        alignment: Alignment.center,
      ));
    }

    ZhText data = Html2Widget.parseZhText(htmlText: htmlBody);
    const headColor = Color.fromRGBO(145, 111, 118, 1);
    Size size = MediaQuery.of(context).size;

    return render(ListView(
      children: [
        Stack(
          children: <Widget>[
            Image(
              image: NetworkImage(headImageUrl ?? ""),
              width: size.width,
              height: size.height * 0.6,
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      headColor.withOpacity(0),
                      headColor.withOpacity(0.55),
                      headColor.withOpacity(1),
                    ],
                        tileMode: TileMode.clamp,
                        begin: Alignment.topCenter,
                        end: Alignment.lerp(
                            Alignment.topCenter, Alignment.bottomCenter, 1))),
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 20),
                        child: Container(
                          child: Text(title ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600)),
                          width: MediaQuery.of(context).size.width - 40,
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, right: 15),
                      child: Align(
                        child: Text(
                          headImageResource ?? "",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[350]),
                          textAlign: TextAlign.right,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: 0,
            ),
          ],
        ),
        Container(
          child: Column(
            children: data?.body,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
        ),
        Container(
          child: Text(
            "到底部啦～",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 10),
        )
      ],
    ));
  }
}
