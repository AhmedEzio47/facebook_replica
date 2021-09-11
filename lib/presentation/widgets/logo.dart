import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget with PreferredSizeWidget {
  final double width, height;

  const Logo({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightBGColor,
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Image.asset(
        kIsWeb ? kWebLogo : kFacebookLogo,
      ),
    );
  }

  @override
  Size get preferredSize => Size(width, height);
}
