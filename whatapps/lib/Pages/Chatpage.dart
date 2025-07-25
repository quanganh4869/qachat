import 'package:flutter/material.dart';
import 'package:whatapps/Custom/CustomCard.dart';
import 'package:whatapps/Model/ChatModel.dart';

class Chatpage extends StatelessWidget {
   Chatpage({Key? key}) : super(key: key);

  final List<ChatModel> chatList = [
    ChatModel(
      name: "John Doe",
      message: "Hello, how are you?",
      time: "10:30 AM",
      currentMessage: "This is a custom card",
      isGroup: false,
    ),
    ChatModel(
      name: "Jane Smith",
      message: "Let's meet tomorrow.",
      time: "9:15 AM",
      currentMessage: "This is another custom card",
      isGroup: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating action button
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) => Customcard(
          chatModel: chatList[index],
          ),
      ),
    );
  }
}