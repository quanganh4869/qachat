import 'package:flutter/material.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/screens/CreateGroup.dart';
import 'package:whatapps/Custom/ButtonCard.dart';

class SelectContact extends StatelessWidget {
  const SelectContact({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Alice",
        currentMessage: "Last seen recently",
      ),
      ChatModel(
        name: "Bob",
        currentMessage: "Last seen recently",
      ),
      ChatModel(
        name: "Charlie",
        currentMessage: "Online",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Select Contact"),
            Text(
              "100 Contacts",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 28),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(value: "Invite a friend", child: Text("Invite a friend")),
                PopupMenuItem(value: "Refresh", child: Text("Refresh")),
                PopupMenuItem(value: "Contact Us", child: Text("Contact Us")),
                PopupMenuItem(value: "Help", child: Text("Help")),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGroup()));
                },
                child: const ButtonCard(icon: Icons.group, name: "Create Group"),
              ),
            );
          } else if (index == 1) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ButtonCard(icon: Icons.person_add, name: "Add Contact"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ContactCard(contact: contacts[index - 2]),
            );
          }
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final ChatModel contact;
  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,
          child: Text(
            contact.name?.substring(0, 1).toUpperCase() ?? "?",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        title: Text(contact.name ?? "Unknown", style: const TextStyle(fontSize: 16)),
        subtitle: Text(contact.message ?? "", maxLines: 1, overflow: TextOverflow.ellipsis),
        onTap: () {
          // xử lý khi bấm vào contact
        },
      ),
    );
  }
}
