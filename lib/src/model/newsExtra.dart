class ZhDailyNewsExtra {
  final int longComments;
  final int popularity;
  final int shortComments;
  final int comments;
  ZhDailyNewsExtra(
      {this.longComments, this.popularity, this.shortComments, this.comments});
  ZhDailyNewsExtra.fromJson(Map data)
      : longComments = data["long_comments"],
        popularity = data["popularity"],
        shortComments = data["short_comments"],
        comments = data["comments"];
  @override
  String toString() =>
      "ZhDailyNewsExtra {longComments:$longComments,popularity:$popularity,shortComments:$shortComments,comment:$comments}";
}
