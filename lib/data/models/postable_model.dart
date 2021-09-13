class PostableModel {
  int id;
  int userId;
  String? text;
  DateTime timestamp;

  PostableModel(
      {required this.id,
      this.text,
      required this.timestamp,
      required this.userId});

  factory PostableModel.fromRawPost(rawPost) {
    return PostableModel(
      id: rawPost['id'],
      timestamp:
          DateTime.fromMillisecondsSinceEpoch(rawPost['timestamp'] * 1000),
      userId: rawPost['user_id'],
      text: rawPost['text'],
    );
  }
}
