import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Logo extends StatelessWidget with PreferredSizeWidget {
  final double width, height;

  const Logo({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kAccentColor,
      backwardsCompatibility: false,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      title: Container(
        color: kLightBGColor,
        padding: kIsWeb ? EdgeInsets.all(8) : null,
        height: height,
        width: 120,
        alignment: Alignment.centerLeft,
        child: Image.asset(
          kIsWeb ? kWebLogo : kFacebookLogo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(width, height);
}
