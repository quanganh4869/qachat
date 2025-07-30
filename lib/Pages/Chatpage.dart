import 'package:flutter/material.dart';
import 'package:whatapps/Custom/CustomCard.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/screens/SelectContact.dart';
import 'package:camera/camera.dart';

class Chatpage extends StatelessWidget {
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

  final List<CameraDescription> cameras;

  Chatpage({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectContact(),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) => Customcard(
          chatModel: chatList[index],
          cameras: cameras, // ✅ Truyền cameras cho Customcard
        ),
      ),
    );
  }
}
