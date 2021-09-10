import 'package:facebook_replica/data/models/post_model.dart';

class PostState {
  bool isLoading;
  PostModel? post;
  PostState({this.isLoading = false, this.post});
}
