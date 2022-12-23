import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/CustomCard.dart';
import 'package:whats_app_clone/Screens/SelectContact.dart';

import '../Model/ChatModel.dart';
import '../utils/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Dev Stack",
        icon: "person.svg",
        currentMessage: "Hi everyone",
        isGroup: false,
        time: "4:00"),
    ChatModel(
        name: "Kishor",
        icon: "person.svg",
        currentMessage: "Hi Kishor",
        isGroup: false,
        time: "10:00"),
    ChatModel(
        name: "Collins",
        icon: "person.svg",
        currentMessage: "Hi Collins",
        isGroup: true,
        time: "12:00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: chats[index],
          );
        },
      ),
    );
  }
}
