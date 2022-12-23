class ChatModel{
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool? select;
  ChatModel({
     this.name,
     this.icon,
     this.currentMessage,
     this.isGroup,
     this.time,
     this.status,
     this.select = false
});
}