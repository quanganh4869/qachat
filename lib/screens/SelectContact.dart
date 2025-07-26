import 'package:flutter/material.dart';
import 'package:whatapps/Custom/ButtonCard.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/Custom/ContactCard.dart';

class SelectContact extends StatelessWidget {
  const SelectContact({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Alice",
        message: "Hey there!",
        time: "12:00 PM",
        currentMessage: "Last seen recently",
        isGroup: false,
      ),
      ChatModel(
        name: "Bob",
        message: "Let's catch up!",
        time: "1:00 PM",
        currentMessage: "Last seen recently",
        isGroup: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Select Contact"),
            Text(
              "100 Contacts",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 30),
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
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ButtonCard(icon: Icons.group, name: "Create Group");
          } else if (index == 1) {
            return const ButtonCard(icon: Icons.person_add, name: "Add Contact");
          } else {
            return ContactCard(
              contact: contacts[index - 2],
            );
          }
        },
      ),
    );
  }
}
