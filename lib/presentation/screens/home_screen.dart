import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:facebook_replica/presentation/widgets/left_panel.dart';
import 'package:facebook_replica/presentation/widgets/logo.dart';
import 'package:facebook_replica/presentation/widgets/post_item.dart';
import 'package:facebook_replica/presentation/widgets/right_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<PostBloc>(context)
        .add(PostEvent(type: PostEventType.request));
  }

  List<PostState> _posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: Logo(
        width: MediaQuery.of(context).size.width,
        height: 60,
      ),
      body: LayoutBuilder(
        builder: (context, boxConstraints) => Row(
          children: [
            if (kIsWeb && boxConstraints.maxWidth > kWebPostListWidth)
              Expanded(flex: 3, child: LeftPanel()),
            Expanded(
              flex: 4,
              child: BlocListener<PostBloc, PostState>(
                  listener: (context, postState) {
                    if (postState.post != null) {
                      _posts.removeWhere((element) => element.post == null);
                    }
                    setState(() {
                      _posts.add(postState);
                    });
                  },
                  child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        return BlocProvider<UserBloc>(
                          create: (context) => UserBloc(),
                          child: PostItem(
                            key: Key((_posts[index].post?.id ?? 0).toString()),
                            postState: _posts[index],
                          ),
                        );
                      })),
            ),
            if (kIsWeb && boxConstraints.maxWidth > kWebPostListWidth)
              Expanded(flex: 3, child: RightPanel())
          ],
        ),
      ),
    );
  }
}
