import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/constants/dummy_data.dart';
import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      width: kWebPostListWidth,
      child: ListView.builder(
        itemBuilder: (context, index) => buildItem(index),
        itemCount: MENU.length,
      ),
    );
  }

  Widget buildItem(int index) {
    return Container(
      height: kLeftPanelItemHeight,
      child: Row(
        children: [
          Image.asset(
            MENU[index]['icon'],
            width: kLeftPanelIconSize,
            height: kLeftPanelIconSize,
          ),
          SizedBox(
            width: 10,
          ),
          Text(MENU[index]['label'])
        ],
      ),
    );
  }
}
