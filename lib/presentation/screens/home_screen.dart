import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/logic/blocs/post_bloc.dart';
import 'package:facebook_replica/logic/events/post_event.dart';
import 'package:facebook_replica/logic/states/post_state.dart';
import 'package:facebook_replica/presentation/widgets/logo.dart';
import 'package:facebook_replica/presentation/widgets/post_item.dart';
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
      appBar: Logo(
        width: MediaQuery.of(context).size.width,
        height: 60,
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, postState) {
          setState(() {
            _posts.add(postState);
          });
        },
        builder: (context, state) => ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return PostItem(
                key: Key((_posts[index].post?.id ?? 0).toString()),
                postState: _posts[index],
              );
            }),
      ),
    );
  }
}
