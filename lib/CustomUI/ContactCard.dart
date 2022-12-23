import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/Model/ChatModel.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class ContactCard extends StatefulWidget {
  final ChatModel contact;

  const ContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: Dimensions.height10 * 5 + Dimensions.height30 / 10,
        width: Dimensions.width10 * 5,
        child: Stack(
          children: [
            CircleAvatar(
              radius: Dimensions.radius20 + Dimensions.radius30 / 10,
              child: SvgPicture.asset(
                widget.contact.isGroup == null ||
                        widget.contact.isGroup == false
                    ? "assets/images/person.svg"
                    : "assets/images/groups.svg",
                color: Colors.white,
                height: Dimensions.height30,
                width: Dimensions.width30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            widget.contact.select == true
                ? Positioned(
                    bottom: Dimensions.height2 * 2,
                    right: Dimensions.width30 / 6,
                    child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: Dimensions.radius15 - Dimensions.radius20 / 5,
                        child: Icon(Icons.check,
                            color: Colors.white,
                            size: Dimensions.iconSize16 +
                                Dimensions.iconSize16 / 8)))
                : Container()
          ],
        ),
      ),
      title: CustomText(
        text: widget.contact.name!,
        fontSize: Dimensions.font16,
        fontWeight: FontWeight.bold,
      ),
      subtitle: CustomText(
        text: widget.contact.status!,
        fontSize: Dimensions.font13,
      ),
    );
  }
}
