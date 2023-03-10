import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app_clone/CustomUI/CustomText.dart';
import 'package:whats_app_clone/CustomUI/OwnMessageCard.dart';
import 'package:whats_app_clone/CustomUI/ReplayMessageCard.dart';
import 'package:whats_app_clone/Model/ChatModel.dart';
import 'package:whats_app_clone/utils/colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Model/MessageModel.dart';
import '../utils/dimensions.dart';
import '../utils/emoji_picker/emoji_pikcer_2.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;

  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.68:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("/signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background_Img
        Image.asset(
          "assets/images/chat_back.png",
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,

          /// AppBar
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: Dimensions.width10 * 7,
            backgroundColor: AppColors.primaryColor,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: Dimensions.iconSize24,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup!
                          ? "assets/images/groups.svg"
                          : "assets/images/person.svg",
                      color: Colors.white,
                      height: Dimensions.height36,
                      width: Dimensions.width36,
                    ),
                    radius: Dimensions.radius20 / 10 + Dimensions.radius20,
                    backgroundColor: Colors.blueGrey,
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(Dimensions.height30 / 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.chatModel.name!,
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "last seen today at 12.05",
                      fontSize: Dimensions.font13,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton<String>(onSelected: (value) {
                print(value);
              }, itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    value: "View Contact",
                    child: Text("View Contact"),
                  ),
                  PopupMenuItem(
                    value: "Media, links and docs",
                    child: Text("Media, links and docs"),
                  ),
                  PopupMenuItem(
                    value: "Whatsapp Web",
                    child: Text("Whatsapp Web"),
                  ),
                  PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  PopupMenuItem(
                    value: "Mute Notification",
                    child: Text("Mute Notification"),
                  ),
                  PopupMenuItem(
                    value: "Wallpaper",
                    child: Text("Wallpaper"),
                  ),
                ];
              }),
            ],
          ),

          /// Body
          body: Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  /// Chat messages ListView
                  Expanded(
                    // height: Dimensions.screenHeight - Dimensions.height20 * 7,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: Dimensions.height10 * 7,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                              message: messages[index].message!,
                              time: messages[index].time!);
                        } else {
                          return ReplayMessageCard(
                              message: messages[index].message!,
                              time: messages[index].time!);
                        }
                      },
                    ),
                  ),

                  /// Type message
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              /// Chat message TextFormField
                              Container(
                                  width: Dimensions.screenWidth -
                                      Dimensions.width10 * 5.5,
                                  child: Card(
                                      margin: EdgeInsets.only(
                                          left: Dimensions.width20 / 10,
                                          right: Dimensions.width20 / 3,
                                          bottom: Dimensions.height2 * 4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 +
                                                  Dimensions.radius15 / 3)),
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            setState(() {
                                              sendButton = true;
                                            });
                                          } else {
                                            sendButton = false;
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width20 / 4,
                                                    vertical: Dimensions
                                                            .height10 /
                                                        2),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (builder) =>
                                                              bottomSheet());
                                                    },
                                                    icon: Icon(
                                                      Icons.attach_file,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            prefixIcon: IconButton(
                                              icon: Icon(
                                                Icons.emoji_emotions,
                                                color: AppColors.primaryColor,
                                              ),
                                              onPressed: () {
                                                focusNode.unfocus();
                                                focusNode.canRequestFocus =
                                                    false;
                                                setState(() {
                                                  show = !show;
                                                });
                                              },
                                            )),
                                      ))),

                              /// Microphone
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: Dimensions.height2 * 4,
                                    right: Dimensions.width20 / 10),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.accentColor,
                                  radius: Dimensions.radius20 +
                                      Dimensions.radius20 / 5,
                                  child: IconButton(
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(microseconds: 300),
                                              curve: Curves.easeOut);
                                          sendMessage(
                                              _controller.text,
                                              widget.sourceChat.id!,
                                              widget.chatModel.id!);
                                          _controller.clear();
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: Dimensions.height30 * 9.5,
      width: Dimensions.screenWidth,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width20 - Dimensions.width10 / 5,
            vertical: Dimensions.height20 - Dimensions.height2),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10, vertical: Dimensions.height20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: Dimensions.width20 * 2,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: Dimensions.width20 * 2,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery")
                ],
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: Dimensions.width20 * 2,
                  ),
                  iconCreation((Icons.location_pin), Colors.teal, "Location"),
                  SizedBox(
                    width: Dimensions.width20 * 2,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: Dimensions.radius30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: Dimensions.iconSize32,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: Dimensions.height10 - Dimensions.height2,
          ),
          CustomText(
            text: text,
            fontSize: Dimensions.font13,
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker2(
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        print(emoji);
        _controller.text = _controller.text + emoji.emoji!;
      },
    );
  }
}
