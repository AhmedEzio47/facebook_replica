import 'package:facebook_replica/constants/colors.dart';
import 'package:facebook_replica/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../animations/fading_rotated_widget/fading_rotated_widget.dart';

Widget kLikesWidget(int likes) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 2),
          alignment: Alignment.center,
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, kPrimaryColor],
              ),
              shape: BoxShape.circle),
          child: Icon(
            FontAwesomeIcons.solidThumbsUp,
            size: 11,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          '$likes',
          style: TextStyle(color: kGreyTextColor),
        ),
      ],
    );

Widget kDivider = Divider(
  color: kDividerColor,
  height: 20,
  thickness: .5,
);

Widget kTextWidget(
  String text, {
  bool expand = false,
}) {
  return Wrap(
    children: [
      SelectableText(
        text,
        maxLines: expand ? 6 : 2,
        //overflow: TextOverflow.ellipsis,
      ),
      text.length > kMaxCharsInPostText
          ? Text(
              expand ? '' : 'See More',
              style: TextStyle(color: kGreyTextColor),
            )
          : Container()
    ],
  );
}

Widget kLikeButton(bool isLiked) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: isLiked
              ? FadingRotatedWidget(
                  child: Icon(
                    FontAwesomeIcons.solidThumbsUp,
                    color: kLightPrimaryColor,
                    size: kReactionIconSize,
                  ),
                )
              : Icon(
                  FontAwesomeIcons.thumbsUp,
                  color: kGreyTextColor,
                  size: kReactionIconSize,
                ),
        ),
        Text(
          ' Like',
          style: TextStyle(color: kGreyTextColor),
        ),
      ],
    );
