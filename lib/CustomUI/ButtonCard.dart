import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/Model/ChatModel.dart';
import 'package:whats_app_clone/utils/colors.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class ButtonCard extends StatefulWidget {
  final String name;
  final IconData icon;

  const ButtonCard({Key? key, required this.name, required this.icon})
      : super(key: key);

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: Dimensions.radius20 + Dimensions.radius30 / 10,
        child: Icon(
          widget.icon,
          color: Colors.white,
          size: Dimensions.iconSize24 + Dimensions.iconSize16 / 8,
        ),
        backgroundColor: AppColors.iconBackColor,
      ),
      title: CustomText(
        text: widget.name,
        fontSize: Dimensions.font16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
