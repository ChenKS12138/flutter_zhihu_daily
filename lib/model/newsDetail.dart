class ZhDailyNewsDetail {
  final String body;
  final String imageHue;
  final String imageSource;
  final String title;
  final String url;
  final String image;
  final String shareUrl;
  final List<String> js;
  final String gaPrefix;
  final List<String> images;
  final int type;
  final int id;
  final List<String> css;
  ZhDailyNewsDetail(
      {this.body,
      this.imageHue,
      this.imageSource,
      this.title,
      this.image,
      this.images,
      this.shareUrl,
      this.js,
      this.gaPrefix,
      this.type,
      this.url,
      this.css,
      this.id});
  ZhDailyNewsDetail.fromJson(Map data)
      : body = data["body"],
        gaPrefix = data["ga_prefix"],
        image = data["image"],
        id = data["id"],
        imageHue = data["image_hue"],
        images = List.from(data["images"] ?? [])
            .map((item) => item.toString())
            .toList(),
        imageSource = data["image_source"],
        js =
            List.from(data["js"] ?? []).map((item) => item.toString()).toList(),
        shareUrl = data["share_url"],
        title = data["title"],
        url = data["url"],
        css = List.from(data["css"] ?? [])
            .map((item) => item.toString())
            .toList(),
        type = data["type"];
  @override
  String toString() =>
      "ZhDailyNewsDetail {body:$body,gaPrefix:$gaPrefix,id:$id,imageHue:$imageHue,images:$images,imageSource:$imageSource,js:$js,shareUrl:$shareUrl,title:$title,url:$url,css:$css,type:$type}";
}
