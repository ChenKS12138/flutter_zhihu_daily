import 'package:zhihu_daily/api/api.dart';

void main(List<String> args) async {
  var a = await Api.getNewsList(time: DateTime.parse("20200218"));
  print(a);
}
