import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/helpers/helper_methods.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/postable_state.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentItem extends StatefulWidget {
  final PostableState comment;
  CommentItem({required this.comment});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UserEvent(
        type: UserEventType.request, data: widget.comment.postable?.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
            userAvatar: context.read<UserBloc>().state.user?.avatar ??
                kDefaultUserAvatar),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<UserBloc>().state.user?.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.comment.postable?.text ?? '',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              formatTimestamp(widget.comment.postable?.timestamp),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: kGreyTextColor),
            )
          ],
        ),
      ],
    );
  }
}
