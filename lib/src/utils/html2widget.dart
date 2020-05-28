import 'package:html/dom.dart' as DOM;
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parse;

class ZhText {
  final String author;
  final List<Widget> body;
  ZhText({this.author, this.body});
}

class Html2Widget {
  // 正文
  static Container genetageParagraph({String text}) => Container(
        child: Text(
          text.length > 2 ? text.substring(1, text.length - 1) : text,
          style: TextStyle(fontSize: 14, color: Colors.grey[900], height: 1.8),
        ),
        margin: EdgeInsets.only(top: 3, bottom: 3),
      );

  // 正文中的重点句子
  static Container generateStrong({String text}) => Container(
        child: Text(
          text,
          style:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.8),
        ),
        margin: EdgeInsets.only(top: 3, bottom: 3),
      );

  //正文链接
  static Container generateA({String text, String href}) => Container(
        child: Text(
          text,
          style:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.8),
        ),
        margin: EdgeInsets.only(top: 3, bottom: 3),
      );

  // 正文图片
  static Container generateImage({String src}) => Container(
        child: Image(
          image: NetworkImage(src),
        ),
        margin: EdgeInsets.only(top: 10, bottom: 10),
      );

  // 标题
  static Text generateTitle({String text}) => Text(text);

  static List<Widget> parseZhTextBody({DOM.Element dom}) => dom.children
      .map((child) => child.nodes.map((node) {
            if (node.nodeType == DOM.Node.TEXT_NODE) {
              return genetageParagraph(text: node.toString());
            }
            if (node is DOM.Element) {
              final String tagName = node.localName.toString();
              switch (tagName) {
                case 'img':
                  return generateImage(src: node.attributes["src"] ?? "");
                case 'strong':
                  return generateStrong(text: node.text);
                case 'a':
                  return generateA(
                      text: node.text, href: node.attributes["href"]);
                case 'br':
                  return genetageParagraph(text: " ");
              }
              print(tagName);
              return genetageParagraph(text: node.text);
            }
            print(node.nodeType);
            return null;
          }).toList())
      .fold([], (prev, current) => prev + current);

  static ZhText parseZhText({String htmlText}) {
    if (htmlText == null) return null;
    DOM.Document dom = parse.parse(htmlText);
    return ZhText(
        author:
            dom.querySelector(".author").text.replaceAll(RegExp(r'(,|，)'), ""),
        body: parseZhTextBody(dom: dom.querySelector(".content")));
  }
}
