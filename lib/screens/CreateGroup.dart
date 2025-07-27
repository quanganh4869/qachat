import 'package:flutter/material.dart';
import 'package:whatapps/Custom/AvatarCard.dart';
import 'package:whatapps/Custom/ContactCard.dart';
import 'package:whatapps/Model/ChatModel.dart';

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
  ];

  final List<ChatModel> groupmember = [];

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 30)),
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
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groupmember.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    if (!contacts[index - 1].selected) {
                      contacts[index - 1].selected = true;
                      groupmember.add(contacts[index - 1]);
                    } else {
                      contacts[index - 1].selected = false;
                      groupmember.remove(contacts[index - 1]);
                    }
                  });
                },
                child: ContactCard(contact: contacts[index - 1]),
              );
            },
          ),
          if (groupmember.isNotEmpty)
            Column(
              children: [
                Container(
                  height: 75,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      if (contacts[index].selected == true) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              groupmember.remove(contacts[index]);
                              contacts[index].selected = false;
                            });
                          },
                          child: AvatarCard(contact: contacts[index]),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                const Divider(thickness: 1),
              ],
            ),
        ],
      ),
    );
  }
}
