import 'package:facebook_replica/data/models/postable_model.dart';

class PostableState {
  bool isLiked;
  PostableModel? postable;
  String? error;
  PostableState({this.postable, this.isLiked = false, this.error});
}
