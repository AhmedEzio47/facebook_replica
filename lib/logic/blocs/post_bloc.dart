import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/data/repos/posts_repo.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState()) {}

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    switch (event.type) {
      case PostEventType.request:
        this.add(PostEvent(type: PostEventType.loading));
        List<PostModel>? posts = await PostsRepo().getPosts();

        if (posts != null)
          this.add(PostEvent(type: PostEventType.ready, data: posts));
        else
          this.add(PostEvent(type: PostEventType.error));

        break;
      case PostEventType.loading:
        yield PostState(isLoading: true);
        break;
      case PostEventType.ready:
        for (var post in (event.data as List)) {
          yield PostState(
            post: post,
          );
        }
        break;
      case PostEventType.like:
        break;
      case PostEventType.error:
        yield PostState();
        break;
    }
  }
}
