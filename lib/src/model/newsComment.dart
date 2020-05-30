class ZhDailyNewsCommentItem {
  final String author;
  final String content;
  final String avatar;
  final DateTime time;
  final int id;
  final int likes;
  ZhDailyNewsCommentItem(
      {this.author, this.content, this.avatar, this.time, this.id, this.likes});
  ZhDailyNewsCommentItem.fromJson(Map data)
      : author = data["author"],
        content = data["content"],
        time = DateTime.fromMillisecondsSinceEpoch(data["time"] * 1000),
        id = data["id"],
        likes = data["likes"],
        avatar = data["avatar"];

  @override
  String toString() =>
      "ZhDailyNewsCommentItem {author:$author,content:$content,avatar:$avatar,time:$time,id:$id,likes:$likes}";
}

class ZhDailyNewsComment {
  final List<ZhDailyNewsCommentItem> comments;

  int get count => comments?.length ?? 0;

  ZhDailyNewsComment({this.comments});
  ZhDailyNewsComment.fromJson(Map data)
      : comments = List.from(data["comments"] ?? [])
            .map((item) => ZhDailyNewsCommentItem.fromJson(item))
            .toList();

  @override
  String toString() => "ZhDailyNewsComment {comments: $comments}";
}
