import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/Model/ChatModel.dart';

import '../utils/dimensions.dart';
import 'CustomText.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.width10/5, horizontal: Dimensions.width45/5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: Dimensions.radius20 + Dimensions.radius30 / 10,
                child: SvgPicture.asset(
                    "assets/images/person.svg",
                  color: Colors.white,
                  height: Dimensions.height30,
                  width: Dimensions.width30,
                ),
                backgroundColor: Colors.blueGrey[200],
              ),

                  Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: Dimensions.radius15 - Dimensions.radius20 / 5,
                      child: Icon(Icons.clear,
                          color: Colors.white,
                          size: Dimensions.iconSize16 -
                              Dimensions.iconSize24/8)))
            ],
          ),
          SizedBox(
            height: Dimensions.height2,
          ),
          CustomText(text: chatModel.name!, fontSize: Dimensions.font13,),
        ],
      ),
    );
  }
}
