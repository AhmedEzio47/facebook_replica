import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/postable_model.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentItem extends StatelessWidget {
  PostableModel comment;
  CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => Row(
        children: [UserAvatar(userAvatar: state.user?.avatar ?? kDefaultUser)],
      ),
    );
  }
}
