class ChatModel {
  String? name;
  String? message;
  String? time;
  String? currentMessage;
  String? status;
  bool? isGroup;
  bool selected = false;

  ChatModel({
    this.name,
    this.message,
    this.time,
    this.currentMessage,
    this.status,
    this.isGroup,
    this.selected = false,
  });
}
