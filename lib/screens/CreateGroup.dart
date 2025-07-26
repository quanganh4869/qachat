import 'package:flutter/material.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/Custom/ContactCard.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final List<ChatModel> contacts = [
    ChatModel(name: "Alice", status: "online"),
    ChatModel(name: "Bob", status: "offline"),
    ChatModel(name: "Charlie", status: "busy"),
    ChatModel(name: "David", status: "away"),
    // Add more contacts as needed
  ];

  final List<ChatModel> group = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 20,
               fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(Icons.search, size: 30),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                PopupMenuItem(
                  value: "Contact Us",
                  child: Text("Contact Us"),
                ),
                PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
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
