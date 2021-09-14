import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/data/repos/posts_repo.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostableBloc extends Bloc<PostEvent, PostableState> {
  PostableBloc() : super(PostableState());

  @override
  Stream<PostableState> mapEventToState(PostEvent event) async* {
    switch (event.type) {
      case PostEventType.request:
        List<PostModel>? posts = await PostsRepo().getPosts();
        if (posts != null)
          this.add(PostEvent(type: PostEventType.ready, data: posts));
        else
          this.add(
              PostEvent(type: PostEventType.error, data: 'Unexpected error!'));

        break;
      case PostEventType.ready:
        for (PostModel post in (event.data as List)) {
          yield PostableState(postable: post, isLiked: post.isLiked);
        }
        break;
      case PostEventType.like:
        PostableState postState = event.data;
        PostModel postModel = (postState.postable as PostModel);
        postModel.isLiked = !postState.isLiked;
        postModel.isLiked ? postModel.likes++ : postModel.likes--;
        PostableState newPostState =
            PostableState(isLiked: !postState.isLiked, postable: postModel);
        yield newPostState;
        break;
      case PostEventType.comment:
        PostableState postState = event.data;
        yield PostableState(postable: postState.postable);
        break;
      case PostEventType.error:
        yield PostableState(error: event.data);
        break;
    }
  }
}
