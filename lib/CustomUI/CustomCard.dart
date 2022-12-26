import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app_clone/Screens/IndividualPage.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

import '../Model/ChatModel.dart';
import 'CustomText.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;

  const CustomCard({Key? key, required this.chatModel, required this.sourceChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel,
                      sourceChat: sourceChat
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: Dimensions.radius30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                  chatModel.isGroup!
                      ? "assets/images/groups.svg"
                      : "assets/images/person.svg",
                  color: Colors.white,
                  height: Dimensions.height38,
                  width: Dimensions.width38),
            ),
            title: CustomText(
              text: chatModel.name!,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: Dimensions.width30 / 10,
                ),
                CustomText(
                  text: chatModel.currentMessage!,
                  fontSize: Dimensions.font13,
                ),
              ],
            ),
            trailing: Text(chatModel.time!),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: Dimensions.width30, left: Dimensions.width20 * 4),
            child: Divider(
              thickness: Dimensions.height2 / 2,
            ),
          )
        ],
      ),
    );
  }
}
