import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/AvatarCard.dart';
import 'package:whats_app_clone/CustomUI/ButtonCard.dart';
import 'package:whats_app_clone/CustomUI/ContactCard.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/utils/colors.dart';
import 'package:whats_app_clone/utils/dimensions.dart';
import '../Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Sultan", status: "A full stack developer"),
    ChatModel(name: "Saket", status: "amangeldiev sultan"),
    ChatModel(name: "Balram", status: "Web develop"),
    ChatModel(name: "Dev", status: "App developer"),
    ChatModel(name: "Sultan", status: "A full stack developer"),
    ChatModel(name: "Saket", status: "amangeldiev sultan"),
    ChatModel(name: "Balram", status: "Web develop"),
    ChatModel(name: "Dev", status: "App developer"),
  ];

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "New Group",
              fontSize: Dimensions.font20,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: "Add participants",
              fontSize: Dimensions.font13,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: Dimensions.iconSize24 + Dimensions.iconSize16 / 8,
              )),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if(index == 0){
                  return Container(
                    height: groups.length > 0 ? Dimensions.height45*2 : Dimensions.height10,
                  );
                }
                return InkWell(
                    onTap: () {
                      if (contacts[index- 1].select == false) {
                        setState(() {
                          contacts[index-1].select = true;
                          groups.add(contacts[index-1]);
                        });
                      } else {
                        setState(() {
                          contacts[index-1].select = false;
                          groups.remove(contacts[index-1]);
                        });
                      }
                    },
                    child: ContactCard(
                      contact: contacts[index-1],
                    ));
              }),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: Dimensions.height45 + Dimensions.height30,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      groups.remove(contacts[index]);
                                      contacts[index].select = false;
                                    });
                                  },
                                  child: AvatarCard(
                                    chatModel: contacts[index],
                                  ));
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
