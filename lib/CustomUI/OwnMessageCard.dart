import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/utils/colors.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.time}) : super(key: key);
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Dimensions.screenWidth - Dimensions.width45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius8)),
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width15,
              vertical: Dimensions.height10 / 2),
          color: AppColors.messageColor,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width30 * 2,
                    top: Dimensions.height10 / 2,
                    bottom: Dimensions.height20),
                child: CustomText(
                  text: message,
                  fontSize: Dimensions.font16,
                ),
              ),
              Positioned(
                bottom: Dimensions.height2 * 2,
                right: Dimensions.width10,
                child: Row(
                  children: [
                    CustomText(
                      text: time,
                      fontSize: Dimensions.font13,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    Icon(
                      Icons.done_all,
                      size: Dimensions.iconSize20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
