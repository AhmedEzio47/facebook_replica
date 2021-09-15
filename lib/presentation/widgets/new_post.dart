import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/post_model.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/postable_state.dart';
import 'package:facebook_replica/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatefulWidget {
  final int postId;

  const NewPost({Key? key, required this.postId}) : super(key: key);
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                'Create Post',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300, shape: BoxShape.circle),
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    color: kGreyTextColor,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          kDivider,
          TextField(
            controller: _textEditingController,
            style: TextStyle(color: kBlackTextColor, fontSize: 20),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'What\'s on your mind?',
                hintStyle: TextStyle(color: kGreyTextColor, fontSize: 20)),
            minLines: 4,
            maxLines: 5,
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            height: 40,
            padding: EdgeInsets.all(8),
            color: kLightPrimaryColor,
            minWidth: MediaQuery.of(context).size.width,
            onPressed: _submitPost,
            child: Text(
              'Post',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  void _submitPost() {
    BlocProvider.of<PostableBloc>(context).add(
      PostEvent(
        type: PostEventType.add,
        data: PostableState(
          postable: PostModel(widget.postId, DateTime.now(), kCurrentUserId,
              _textEditingController.text,
              comments: [], likes: 0),
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}
