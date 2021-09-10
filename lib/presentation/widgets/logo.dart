import 'package:facebook_replica/constants.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget with PreferredSizeWidget {
  final double width, height;

  const Logo({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Image.asset(kFacebook_logo),
    );
  }

  @override
  Size get preferredSize => Size(width, height);
}
