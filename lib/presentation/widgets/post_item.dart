import 'package:carousel_slider/carousel_slider.dart';
import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/helpers/helper_methods.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostItem extends StatefulWidget {
  final PostState? postState;
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
    _userId = widget.postState?.post?.userId ?? 0;
    _images = widget.postState?.post?.images ?? [];
    BlocProvider.of<UserBloc>(context)
        .add(UserEvent(type: UserEventType.request, data: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return !(widget.postState?.isLoading ?? false)
        ? buildPost()
        : buildLoadingState();
  }

  Widget buildPost() {
    return BlocBuilder<UserBloc, UserState>(
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
            textWidget(),
            SizedBox(
              height: 10,
            ),
            Center(child: imageWidget()),
            divider(),
            likesAndCommentsRow(),
            divider(),
            reactionRow()
          ],
        ),
      ),
    );
  }

  Widget buildLoadingState() {
    return Container(
      margin: EdgeInsets.all(8),
      color: kBGColor,
      height: kPostLoadingHeight,
      child: Center(
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ))),
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
                  formatTimestamp(widget.postState?.post?.timestamp),
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

  Widget textWidget() {
    return Wrap(
      children: [
        Text(
          widget.postState?.post?.text ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        (widget.postState?.post?.text?.length ?? 0) > kMaxCharsInPostText
            ? InkWell(
                //TODO go to post screen
                child: Text(
                  'See More',
                  style: TextStyle(color: kGreyTextColor),
                ),
              )
            : Container()
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
              ) //TODO convert to carousel
            : Container();
  }

  Widget likesAndCommentsRow() {
    int likes = widget.postState?.post?.likes ?? 0;
    int comments = widget.postState?.post?.comments ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        likes > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, kPrimaryColor],
                        ),
                        shape: BoxShape.circle),
                    child: Icon(
                      FontAwesomeIcons.solidThumbsUp,
                      size: 11,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '$likes',
                    style: TextStyle(color: kGreyTextColor),
                  ),
                ],
              )
            : Container(
                width: 0,
              ),
        comments > 0
            ? Text(
                '$comments Comments',
                style: TextStyle(color: kGreyTextColor),
              )
            : Container(),
      ],
    );
  }

  Widget divider() {
    return Divider(
      color: kDividerColor,
      height: 20,
      thickness: .5,
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
              BlocProvider.of<PostBloc>(context).add(
                  PostEvent(type: PostEventType.like, data: widget.postState));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    (widget.postState?.isLiked ?? false)
                        ? FontAwesomeIcons.solidThumbsUp
                        : FontAwesomeIcons.thumbsUp,
                    color: (widget.postState?.isLiked ?? false)
                        ? Colors.blueAccent
                        : kGreyTextColor,
                  ),
                ),
                Text(
                  ' Like',
                  style: TextStyle(color: kGreyTextColor),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.comment,
                color: kGreyTextColor,
              ),
              Text(
                ' Comment',
                style: TextStyle(color: kGreyTextColor),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.shareSquare,
                color: kGreyTextColor,
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
}
