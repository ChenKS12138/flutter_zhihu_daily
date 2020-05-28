class ZhDailyNewsHotItem {
  final int newsId;
  final String url;
  final String thumbnail;
  final String title;
  ZhDailyNewsHotItem({this.newsId, this.url, this.thumbnail, this.title});
  @override
  String toString() =>
      "ZhDailyNewsHotItem {newsId:$newsId,url:$url,thumbnail:$thumbnail,title:$title}";
}

class ZhDailyNewsHot {
  final List<ZhDailyNewsHotItem> recent;
  ZhDailyNewsHot.fromJson(Map data)
      : recent = List.from(data["recent"] ?? [])
            .map((item) => ZhDailyNewsHotItem(
                newsId: item["news_id"],
                thumbnail: item["thumbnail"],
                title: item["title"],
                url: item["url"]))
            .toList();
  @override
  String toString() => "ZhDailyNewsHot {recent:$recent}";
}
