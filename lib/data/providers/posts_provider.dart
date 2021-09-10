import 'package:facebook_replica/constants/dummy_data.dart';

class PostsAPI {
  Future getPosts() async {
    await Future.delayed(Duration(seconds: 2));
    return POSTS;
  }
}
