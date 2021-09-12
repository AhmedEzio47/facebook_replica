import 'package:facebook_replica/data/models/post_model.dart';

class PostState {
  bool isLoading;
  bool isLiked;
  PostModel? post;
  PostState({this.isLoading = false, this.post, this.isLiked = false});
}
