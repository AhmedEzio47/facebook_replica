import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/postable_state.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:facebook_replica/presentation/widgets/common_widgets.dart';
import 'package:facebook_replica/presentation/widgets/left_panel.dart';
import 'package:facebook_replica/presentation/widgets/logo.dart';
import 'package:facebook_replica/presentation/widgets/new_post.dart';
import 'package:facebook_replica/presentation/widgets/post_item.dart';
import 'package:facebook_replica/presentation/widgets/right_panel.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<PostableBloc>(context)
        .add(PostEvent(type: PostEventType.request));
    BlocProvider.of<UserBloc>(context)
        .add(UserEvent(type: UserEventType.request, data: kCurrentUserId));
  }

  List<PostableState> _posts = [];
  bool _shouldExpandDrawer = false;
  UserState? _userState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: !_shouldExpandDrawer || !kIsWeb
          ? Container(
              color: kAccentColor,
              child: LeftPanel(),
              width: kDrawerWidth,
            )
          : null,
      backgroundColor: kBGColor,
      appBar: Logo(
        height: kAppbarHeight,
        width: MediaQuery.of(context).size.width,
      ),
      body: LayoutBuilder(
        builder: (context, boxConstraints) {
          bool shouldExpandDrawer = boxConstraints.maxWidth > kWebPostListWidth;

          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
            setState(() {
              _shouldExpandDrawer = shouldExpandDrawer;
            });
          });

          return Row(
            children: [
              if (kIsWeb && shouldExpandDrawer)
                Expanded(flex: 3, child: LeftPanel()),
              Expanded(
                flex: 4,
                child: BlocListener<PostableBloc, PostableState>(
                    listener: (context, postState) {
                      if (postState.postable != null) {
                        _posts
                            .removeWhere((element) => element.postable == null);
                      }
                      if (!(_posts
                          .where((element) =>
                              element.postable?.id == postState.postable?.id)
                          .isNotEmpty)) {
                        setState(() {
                          _posts.add(postState);
                          _posts.sort((a, b) =>
                              (b.postable?.timestamp ?? DateTime.now())
                                  .difference(
                                      a.postable?.timestamp ?? DateTime.now())
                                  .inMilliseconds);
                        });
                      } else {
                        if (postState.postable != null)
                          setState(() {
                            int index = _posts.indexWhere((element) =>
                                (element.postable?.id ?? 0) ==
                                postState.postable?.id);
                            _posts[index] = postState;
                          });
                      }
                    },
                    child: Column(
                      children: [
                        newPost(),
                        Expanded(
                          child: _posts.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _posts.length,
                                  itemBuilder: (context, index) {
                                    return BlocProvider<UserBloc>(
                                      create: (context) => UserBloc(),
                                      child: PostItem(
                                        key: Key(
                                            (_posts[index].postable?.id ?? 0)
                                                .toString()),
                                        postState: _posts[index],
                                      ),
                                    );
                                  })
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    )),
              ),
              if (kIsWeb && boxConstraints.maxWidth > kWebPostListWidth * 1.5)
                Expanded(flex: 3, child: RightPanel())
            ],
          );
        },
      ),
    );
  }

  Widget newPost() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(color: kAccentColor),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                UserAvatar(
                    userAvatar: state.user?.avatar ?? kDefaultUserAvatar),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        onTap: () => _goToNewPost(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What\'s on your mind?',
                            hintStyle: TextStyle(color: kGreyTextColor)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            kDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/live-video.png',
                      color: Colors.redAccent,
                      scale: 6,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Live Video',
                      style: TextStyle(color: kGreyTextColor),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.photoVideo,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Live Video',
                      style: TextStyle(color: kGreyTextColor),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.smile,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Photo/Video',
                      style: TextStyle(color: kGreyTextColor),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _goToNewPost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: NewPost(
                postId: _posts.length + 1,
              ),
            ));
  }
}
