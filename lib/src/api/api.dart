import 'package:dio/dio.dart';

import '../model/newsComment.dart';
import '../model/newsDetail.dart';
import '../model/newsExtra.dart';
import '../model/newsHot.dart';
import '../model/newsList.dart';

/// reference https://www.jianshu.com/p/ee556871da51
class Api {
  static const String BASE_URL = 'http://news-at.zhihu.com/api/4';

  static final Dio instance = new Dio()
    ..options = BaseOptions(baseUrl: BASE_URL);

  static void enableLogger() {
    instance.interceptors.add(LogInterceptor(responseBody: true));
  }

  // 获取新闻列表
  static Future<ZhDailyNewsList> getNewsList({DateTime time}) async {
    final String dateString = time.year.toString() +
        time.month.toString().padLeft(2, "0") +
        time.day.toString().padLeft(2, "0");
    Response response = await instance.get("/news/before/$dateString");
    return ZhDailyNewsList.fromJson(response.data);
  }

  // 获取今日的stories
  static Future<ZhDailyNewsList> getNewsListNow() async {
    Response response = await instance.get("/news/latest");
    return ZhDailyNewsList.fromJson(response.data);
  }

  // 获取新闻的额外信息
  static Future<ZhDailyNewsExtra> getNewsExtra({int id}) async {
    Response response = await instance.get("/story-extra/$id");
    return ZhDailyNewsExtra.fromJson(response.data);
  }

  // 获取新闻评论
  static Future<ZhDailyNewsComment> getNewsLongComments({int id}) async {
    Response response = await instance.get("/story/$id/short-comments");
    return ZhDailyNewsComment.fromJson(response.data);
  }

  // 获取新闻短评论
  static Future<ZhDailyNewsComment> getNewsShortComments({int id}) async {
    Response response = await instance.get("/story/$id/short-comments");
    return ZhDailyNewsComment.fromJson(response.data);
  }

  // 获取新闻长评论
  static Future<ZhDailyNewsHot> getNewsHot() async {
    Response response = await instance.get("/news/hot");
    return ZhDailyNewsHot.fromJson(response.data);
  }

  // 获取新闻详情
  static Future<ZhDailyNewsDetail> getNewsDetail({int id}) async {
    Response response = await instance.get("/news/$id");
    return ZhDailyNewsDetail.fromJson(response.data);
  }
}
