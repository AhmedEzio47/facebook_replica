import 'package:facebook_replica/data/models/postable_model.dart';

class PostableState {
  bool isLoading;
  bool isLiked;
  PostableModel? postable;
  PostableState({this.isLoading = false, this.postable, this.isLiked = false});
}
