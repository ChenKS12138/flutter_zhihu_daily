import 'package:flutter/material.dart';

import '../pages/about.dart';
import '../pages/detail.dart';
import '../pages/index.dart';

Map<String, Widget Function(BuildContext)> myRoute = {
  '/': (context) => Index(),
  '/detail': (context) => Detail(),
  '/about': (context) => About()
};
