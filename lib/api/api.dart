import 'package:dio/dio.dart';
import '../model/newsComment.dart';
import '../model/newsDetail.dart';
import '../model/newsExtra.dart';
import '../model/newsHot.dart';
import '../model/newsList.dart';

/// reference https://www.jianshu.com/p/ee556871da51
class Api {
  static const String BASE_URL = 'http://news-at.zhihu.com/api/4';

  static Future getNewsList({DateTime time}) async {
    if (time == null) {
      Response response = await Dio().get("$BASE_URL/news/latest");
      return ZhDailyNewsList.fromJson(response.data);
    } else {
      final String dateString = time.year.toString() +
          time.month.toString().padLeft(2, "0") +
          time.day.toString().padLeft(2, "0");
      Response response = await Dio().get("$BASE_URL/news/before/$dateString");
      return ZhDailyNewsList.fromJson(response.data);
    }
  }

  static Future<ZhDailyNewsExtra> getNewsExtra({int id}) async {
    Response response = await Dio().get("$BASE_URL/story-extra/$id");
    return ZhDailyNewsExtra.fromJson(response.data);
  }

  static Future<ZhDailyNewsComment> getNewsLongComments({int id}) async {
    Response response = await Dio().get("$BASE_URL/story/$id/short-comments");
    return ZhDailyNewsComment.fromJson(response.data);
  }

  static Future<ZhDailyNewsComment> getNewsShortComments({int id}) async {
    Response response = await Dio().get("$BASE_URL/story/$id/short-comments");
    return ZhDailyNewsComment.fromJson(response.data);
  }

  static Future<ZhDailyNewsHot> getNewsHot() async {
    Response response = await Dio().get("$BASE_URL/news/hot");
    return ZhDailyNewsHot.fromJson(response.data);
  }

  static Future<ZhDailyNewsDetail> getNewsDetail({int id}) async {
    Response response = await Dio().get("$BASE_URL/news/$id");
    return ZhDailyNewsDetail.fromJson(response.data);
  }
}
