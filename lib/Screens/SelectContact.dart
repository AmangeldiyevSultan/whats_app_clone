import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/ButtonCard.dart';
import 'package:whats_app_clone/CustomUI/ContactCard.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/utils/colors.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

import '../Model/ChatModel.dart';
import 'CreateGroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
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
              text: "Select Contact",
              fontSize: Dimensions.font20,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: "256 contact",
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
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem(
                value: "Invite a friend",
                child: Text("Invite a friend"),
              ),
              PopupMenuItem(
                value: "Contacts",
                child: Text("Contacts"),
              ),
              PopupMenuItem(
                value: "Refresh",
                child: Text("Refresh"),
              ),
              PopupMenuItem(
                value: "Help",
                child: Text("Help"),
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => CreateGroup()));
                  },
                  child: ButtonCard(
                    icon: Icons.group,
                    name: "New group",
                  ));
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
            return ContactCard(
              contact: contacts[index - 2],
            );
          }),
    );
  }
}
