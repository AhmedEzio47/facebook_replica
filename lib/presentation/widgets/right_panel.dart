import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/logic/blocs/user_bloc.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:facebook_replica/presentation/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RightPanel extends StatefulWidget {
  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  List<UserState> _users = [];
  @override
  initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context)
        .add(UserEvent(type: UserEventType.requestUsers));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contacts',
            style:
                TextStyle(color: kGreyTextColor, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: BlocListener<UserBloc, UserState>(
                  listener: (context, userState) {
                    if (userState.user != null) {
                      _users.removeWhere((element) => element.user == null);
                    }
                    setState(() {
                      if (!_users.contains(userState)) {
                        _users.add(userState);
                      }
                    });
                  },
                  child: ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (context) => UserBloc(),
                          child: buildItem(index),
                        );
                      })),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      height: kLeftPanelItemHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserAvatar(userAvatar: _users[index].user?.avatar ?? ''),
          SizedBox(
            width: 10,
          ),
          Text(
            _users[index].user?.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
