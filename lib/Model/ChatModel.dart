class ChatModel{
    String name;
    String message;
    String time;        
    String currentMessage;
    bool isGroup;
    ChatModel({
       required this.name,
       required this.message,
       required this.time,
       required this.currentMessage,
       required this.isGroup,
    });
}