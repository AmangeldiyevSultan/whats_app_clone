import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/Page/CameraPage.dart';
import 'package:whats_app_clone/Page/ChatPage.dart';
import 'package:whats_app_clone/utils/colors.dart';

import '../Model/ChatModel.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key,  required this.chatmodels, required this.sourceChat}) : super(key: key);
   final List<ChatModel>? chatmodels;
   final ChatModel sourceChat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Whatsapp Clone"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
              onSelected: (value){
                print(value);
              },
              itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem(
                value: "New group",
                child: Text("New group"),
              ),
              PopupMenuItem(
                value: "New broadcast",
                child: Text("New broadcast"),
              ),
              PopupMenuItem(
                value: "Whatsapp Web",
                child: Text("Whatsapp Web"),
              ),
              PopupMenuItem(
                value: "Started message",
                child: Text("Started message"),
              ),
              PopupMenuItem(
                value: "Setting",
                child: Text("Settings"),
              ),
            ];
          })
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(controller: _controller, children:  [
        CameraPage(),
        ChatPage(chatmodels: widget.chatmodels, sourceChat: widget.sourceChat,),
        Text("status"),
        Text("calls"),
      ]),
    );
  }
}
