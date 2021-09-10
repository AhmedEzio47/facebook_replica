import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/data/providers/posts_provider.dart';

class PostsRepo {
  final PostsAPI _postsAPI = PostsAPI();
  Future<List<PostModel>?> getPosts() async {
    try {
      List<Map> rawPostsData = await _postsAPI.getPosts();
      return rawPostsData
          .map((rawPost) => PostModel.fromRawData(rawPost))
          .toList();
    } catch (ex) {
      print('post repo: $ex');
      return null;
    }
  }
}
