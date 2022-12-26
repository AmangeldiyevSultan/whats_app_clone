import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/CustomCard.dart';
import 'package:whats_app_clone/Screens/SelectContact.dart';

import '../Model/ChatModel.dart';
import '../utils/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatmodels,required this.sourceChat}) : super(key: key);
  final List<ChatModel>? chatmodels;
  final ChatModel sourceChat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


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
        itemCount: widget.chatmodels!.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: widget.chatmodels![index],
            sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
