class PostModel {
  int id;
  String? text;
  List<String>? images;
  int userId;

  PostModel({required this.id, this.text, this.images, required this.userId});
}
