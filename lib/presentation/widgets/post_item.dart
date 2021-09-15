import 'package:carousel_slider/carousel_slider.dart';
import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/helpers/helper_methods.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/postable_state.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:facebook_replica/presentation/widgets/comments_page.dart';
import 'package:facebook_replica/presentation/widgets/common_widgets.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostItem extends StatefulWidget {
  final PostableState? postState;
  PostItem({Key? key, required this.postState}) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int? _userId;
  List? _images;

  @override
  void initState() {
    super.initState();
    _userId = widget.postState?.postable?.userId ?? 0;
    _images = (widget.postState?.postable as PostModel).images ?? [];
    BlocProvider.of<UserBloc>(context)
        .add(UserEvent(type: UserEventType.request, data: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return buildPost();
  }

  bool _shouldExpandText = false;
  bool _showComments = false;

  Widget buildPost() {
    return widget.postState?.error == null
        ? BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => Container(
              color: kLightBGColor,
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authorRow(state),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: !_shouldExpandText
                        ? () {
                            setState(() {
                              _shouldExpandText = true;
                            });
                          }
                        : null,
                    child: kTextWidget(
                      widget.postState?.postable?.text ?? '',
                      expand: _shouldExpandText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: imageWidget()),
                  kDivider,
                  likesAndCommentsRow(),
                  kDivider,
                  reactionRow(),
                  if (kIsWeb && _showComments)
                    SizedBox(
                        height: kCommentsHeight,
                        child: CommentsPage(
                            post: widget.postState ?? PostableState()))
                ],
              ),
            ),
          )
        : Container(
            height: 200,
            child: Center(
              child: Text(widget.postState?.error ?? ''),
            ),
          );
  }

  Widget authorRow(UserState state) {
    return Row(
      children: [
        UserAvatar(
          userAvatar: kUsersAvatars[(_userId ?? 0) - 1],
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.user?.name ?? '',
              key: Key((state.user?.id ?? '').toString()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  formatTimestamp(widget.postState?.postable?.timestamp),
                  style: TextStyle(color: kGreyTextColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  FontAwesomeIcons.solidCircle,
                  size: 4,
                  color: kGreyTextColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  FontAwesomeIcons.globeAmericas,
                  size: 12,
                  color: kGreyTextColor,
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget imageWidget() {
    return _images!.length == 1
        ? Image.asset(_images![0])
        : _images!.length > 1
            ? CarouselSlider(
                items: _images!.map((e) => Image.asset(e)).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                ),
              )
            : Container();
  }

  Widget likesAndCommentsRow() {
    int likes = (widget.postState?.postable as PostModel).likes;
    int comments =
        ((widget.postState?.postable as PostModel).comments ?? []).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        likes > 0
            ? kLikesWidget(likes)
            : Container(
                width: 0,
              ),
        comments > 0
            ? InkWell(
                onTap: goToCommentsPage,
                child: Text(
                  '$comments Comments',
                  style: TextStyle(color: kGreyTextColor),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget reactionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                BlocProvider.of<PostableBloc>(context).add(PostEvent(
                    type: PostEventType.like, data: widget.postState));
              },
              child: kLikeButton((widget.postState?.isLiked ?? false))),
          InkWell(
            onTap: goToCommentsPage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.comment,
                  color: kGreyTextColor,
                  size: kReactionIconSize,
                ),
                Text(
                  ' Comment',
                  style: TextStyle(color: kGreyTextColor),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.shareSquare,
                color: kGreyTextColor,
                size: kReactionIconSize,
              ),
              Text(
                '  Share',
                style: TextStyle(color: kGreyTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToCommentsPage() async {
    if (!kIsWeb)
      await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: true,
          builder: (_) =>
              CommentsPage(post: widget.postState ?? PostableState()));
    else
      setState(() {
        _showComments = !_showComments;
      });
  }
}
