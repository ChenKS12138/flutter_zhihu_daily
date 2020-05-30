import 'package:flutter/material.dart';

import '../pages/about.dart';
import '../pages/comment.dart';
import '../pages/detail.dart';
import '../pages/index.dart';

Map<String, Widget Function(BuildContext)> myRoute = {
  Index.routeName: (context) => Index(),
  Detail.routeName: (context) =>
      Detail(id: Map.from(ModalRoute.of(context).settings.arguments)["id"]),
  About.routeName: (context) => About(),
  Comment.routeName: (context) =>
      Comment(id: Map.from(ModalRoute.of(context).settings.arguments)["id"])
};
