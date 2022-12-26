import 'package:flutter/material.dart';
import 'package:whats_app_clone/CustomUI/ButtonCard.dart';
import 'package:whats_app_clone/Screens/Homescreen.dart';

import '../Model/ChatModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
        id: 1,
        name: "Dev Stack",
        icon: "person.svg",
        currentMessage: "Hi everyone",
        isGroup: false,
        time: "4:00"),
    ChatModel(
        id: 2,
        name: "Kishor",
        icon: "person.svg",
        currentMessage: "Hi Kishor",
        isGroup: false,
        time: "10:00"),
    ChatModel(
        id: 3,
        name: "Binesh",
        icon: "person.svg",
        currentMessage: "Hello!",
        isGroup: false,
        time: "12:00"),
    ChatModel(
        id: 4,
        name: "Naruto",
        icon: "person.svg",
        currentMessage: "Bye",
        isGroup: false,
        time: "12:12"),
    ChatModel(
        id: 5,
        name: "Samat",
        icon: "person.svg",
        currentMessage: "Poka",
        isGroup: false,
        time: "03:23"),
    // ChatModel(
    //     name: "Collins",
    //     icon: "person.svg",
    //     currentMessage: "Hi Collins",
    //     isGroup: true,
    //     time: "12:00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              sourceChat = chats.removeAt(index);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(chatmodels: chats, sourceChat: sourceChat,)));
            },
            child: ButtonCard(
                  name: chats[index].name!,
                  icon: Icons.person,
                ),
          )),
    );
  }
}
