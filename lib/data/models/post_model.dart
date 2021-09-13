import 'package:facebook_replica/data/models/postable_model.dart';

class PostModel extends PostableModel {
  List? images;
  int likes;
  List<PostableModel>? comments;
  bool isLiked;

  PostModel(int id, DateTime timestamp, int userId, String text,
      {this.images, this.likes = 0, this.comments, this.isLiked = false})
      : super(id: id, timestamp: timestamp, userId: userId, text: text);

  factory PostModel.fromRawPost(rawPost) {
    return PostModel(
      rawPost['id'],
      DateTime.fromMillisecondsSinceEpoch(rawPost['timestamp'] * 1000),
      rawPost['user_id'],
      rawPost['text'],
      images: rawPost['images'],
      likes: rawPost['likes'] ?? 0,
      comments: ((rawPost['comments'] ?? []) as List)
          .map((e) => PostableModel.fromRawPost(e))
          .toList(),
      isLiked: rawPost['is_liked'] ?? false,
    );
  }
}
