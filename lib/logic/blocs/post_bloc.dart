import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/data/repos/posts_repo.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    switch (event.type) {
      case PostEventType.request:
        //TODO how to make it a separate function
        for (int i = 0; i < 5; i++) {
          yield PostState(
            isLoading: true,
          );
        }
        List<PostModel>? posts = await PostsRepo().getPosts();

        if (posts != null)
          this.add(PostEvent(type: PostEventType.ready, data: posts));
        else
          this.add(PostEvent(type: PostEventType.error));

        break;
      case PostEventType.loading:
        // for (int i = 0; i < 5; i++) {
        //   yield PostState(
        //     isLoading: true,
        //   );
        // }
        break;
      case PostEventType.ready:
        for (PostModel post in (event.data as List)) {
          yield PostState(post: post, isLiked: post.isLiked);
        }
        break;
      case PostEventType.like:
        PostState postState = event.data;
        PostModel postModel = postState.post!;
        postModel.isLiked = !postState.isLiked;
        postModel.isLiked ? postModel.likes++ : postModel.likes--;
        PostState newPostState =
            PostState(isLiked: !postState.isLiked, post: postModel);
        yield newPostState;
        break;
      case PostEventType.error:
        yield PostState();
        break;
    }
  }
}
