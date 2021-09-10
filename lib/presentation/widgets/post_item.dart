import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final PostState? postState;
  PostItem({Key? key, required this.postState}) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !(widget.postState?.isLoading ?? false)
          ? Text(widget.postState?.post?.text ?? '')
          : CircularProgressIndicator(),
    );
  }
}
