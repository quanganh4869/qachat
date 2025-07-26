import 'package:flutter/material.dart';
import 'package:whatapps/Custom/ButtonCard.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/Custom/ContactCard.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

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
            Text(
              "Select Contact"
              ),
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
         
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {                   
            return InkWell(
              onTap: () {
                // Handle contact selection
              },
              child: ContactCard(
                contact: contacts[index],
              ),
            );        
        },
      ),
    );
  }
}
