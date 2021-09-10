class PostModel {
  int id;
  String? text;
  List? images;
  DateTime timestamp;
  int likes;
  int comments;
  bool isLiked;
  int userId;

  PostModel(
      {required this.id,
      this.text,
      this.images,
      this.likes = 0,
      this.comments = 0,
      this.isLiked = false,
      required this.timestamp,
      required this.userId});

  factory PostModel.fromRawData(rawPost) {
    return PostModel(
      id: rawPost['id'],
      text: rawPost['text'],
      images: rawPost['images'],
      likes: rawPost['likes'] ?? 0,
      comments: rawPost['comments'] ?? 0,
      isLiked: rawPost['is_liked'] ?? false,
      timestamp: DateTime.fromMillisecondsSinceEpoch(rawPost['timestamp']),
      userId: rawPost['user_id'],
    );
  }
}
