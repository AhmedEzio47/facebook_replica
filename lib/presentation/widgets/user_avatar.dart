import 'package:facebook_replica/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String userAvatar;

  const UserAvatar({Key? key, required this.userAvatar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: kIsWeb ? kAvatarRadius - 5 : kAvatarRadius,
      backgroundImage: AssetImage(
        userAvatar,
      ),
    );
  }
}
