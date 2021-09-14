import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:facebook_replica/presentation/widgets/comment_item.dart';
import 'package:facebook_replica/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsPage extends StatefulWidget {
  final PostableState post;

  const CommentsPage({Key? key, required this.post}) : super(key: key);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<CommentsPage> {
  String _newComment = 'a';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostableBloc, PostableState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top: 64),
              itemCount: (widget.post.postable as PostModel).comments?.length,
              itemBuilder: (context, index) => CommentItem(
                comment: PostableState(
                    postable:
                        (widget.post.postable as PostModel).comments?[index]),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      kLikesWidget((widget.post.postable as PostModel).likes),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  kDivider,
                ],
              ),
            )),
            Positioned.fill(
                bottom: MediaQuery.of(context).viewPadding.bottom,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            _newComment = text;
                          });
                        },
                        decoration: InputDecoration(
                            suffix: _newComment.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                : null,
                            border: InputBorder.none,
                            hintText: 'Write a comment',
                            hintStyle: TextStyle(color: kGreyTextColor)),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
