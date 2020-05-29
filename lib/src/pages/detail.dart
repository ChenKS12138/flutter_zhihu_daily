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
  String title;
  String headImageUrl;
  String headImageResource;
  String htmlBody;
  bool loadReady = false;
  @override
  void initState() {
    Api.getNewsDetail(id: widget.id).then((res) {
      this.setState(() {
        this.loadReady = true;
        this.htmlBody = res.body;
        this.title = res.title;
        this.headImageUrl = res.image;
        this.headImageResource = res.imageSource;
      });
    });
    super.initState();
  }

  Widget render(Widget child) {
    return Scaffold(
        appBar: AppBar(
          title: Text("详情"),
        ),
        body: child);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Text("loading...");
    ZhText data = Html2Widget.parseZhText(htmlText: htmlBody);

    if (data == null) {
      return render(Container(
        child: Loading(),
        alignment: Alignment.center,
      ));
    }
    const headColor = Color.fromRGBO(145, 111, 118, 1);
    return render(ListView(
      // children: <Widget>[Text("test")],
      children: [
        Stack(
          children: <Widget>[
            Image(
              image: NetworkImage(headImageUrl ?? ""),
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
        )
      ],
    ));
  }
}
