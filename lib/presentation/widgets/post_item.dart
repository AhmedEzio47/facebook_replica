import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/helpers/helper_methods.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
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
  double loadingHeight = 200;
  int? _userId;
  @override
  void initState() {
    super.initState();
    _userId = widget.postState?.post?.userId ?? 0;
    BlocProvider.of<UserBloc>(context)
        .add(UserEvent(type: UserEventType.request, data: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return !(widget.postState?.isLoading ?? false)
        ? buildPost()
        : buildShimmer();
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
            Row(
              children: [
                CircleAvatar(
                  radius: kAvatarRadius,
                  backgroundImage: AssetImage(
                    kUsersAvatars[(_userId ?? 0) - 1],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userModel?.name ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          formatTimestamp(widget.postState?.post?.timestamp),
                          style: TextStyle(color: kPostTimestampColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          FontAwesomeIcons.solidCircle,
                          size: 4,
                          color: kPostTimestampColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          FontAwesomeIcons.globeAmericas,
                          size: 12,
                          color: kPostTimestampColor,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.postState?.post?.text ?? ''),
          ],
        ),
      ),
    );
  }

  Widget buildShimmer() {
    return Container(
      margin: EdgeInsets.all(8),
      color: kBGColor,
      height: loadingHeight,
      child: Center(
          child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ))),
    );
  }
}
