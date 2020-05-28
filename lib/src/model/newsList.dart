class ZhDailyNewsIntro {
  final String imageHue;
  final String title;
  final String url;
  final String hint;
  final String gaPrefix; //供Google Analytice使用
  final String image;
  final int type;
  final int id;
  ZhDailyNewsIntro(
      {this.imageHue,
      this.title,
      this.url,
      this.hint,
      this.gaPrefix,
      this.image,
      this.type,
      this.id});
  @override
  String toString() =>
      "ZhDailyNewsIntro {imageHue:$imageHue,title:$title,url:$url,hint:$hint,gaPrefix:$gaPrefix,image:$image,type:$type,id:$id}";
}

class ZhDailyNewsList {
  final DateTime date; //日期
  final List<ZhDailyNewsIntro> stories; //当日新闻
  final List<ZhDailyNewsIntro> topStories;
  ZhDailyNewsList.fromJson(Map data)
      : date = DateTime.parse(data["date"]),
        stories =
            ZhDailyNewsList.parseStories(List.from(data["stories"] ?? [])),
        topStories =
            ZhDailyNewsList.parseStories(List.from(data["top_stories"] ?? []));

  static List<ZhDailyNewsIntro> parseStories(List raw) => raw
      .map((item) => ZhDailyNewsIntro(
          gaPrefix: item["ga_prefix"],
          hint: item["hint"],
          id: item["id"],
          imageHue: item["image_hue"],
          image: item["image"] ?? List.from(item["images"] ?? []).elementAt(0),
          title: item["title"],
          type: item["type"],
          url: item["url"]))
      .toList();

  @override
  String toString() =>
      "ZhDailyNewsList {date:$date,stories:$stories,topStories:$topStories}";
}
