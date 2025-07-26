import 'package:flutter/material.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/Custom/ContactCard.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;

  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final List<ChatModel> contacts = [
    ChatModel(name: "Alice", status: "online"),
    ChatModel(name: "Bob", status: "offline"),
    ChatModel(name: "Charlie", status: "busy"),
    ChatModel(name: "David", status: "away"),
  ];

  final List<ChatModel> group = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatModel.name ?? "New Group",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Add participants",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70)),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (!contacts[index].selected) {
                  contacts[index].selected = true;
                  group.add(contacts[index]);
                } else {
                  contacts[index].selected = false;
                  group.remove(contacts[index]);
                }
              });
            },
            child: ContactCard(contact: contacts[index]),
          );
        },
      ),
    );
  }
}
