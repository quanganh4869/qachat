import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: contact.isGroup
              ? SvgPicture.asset(
                  'assets/images/groups.svg', // hình nhóm
                  width: 40,
                  height: 40,
                )
              : Image.asset(
                  'assets/images/person.png', // hình cá nhân
                  width: 40,
                  height: 40,
                ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contact.currentMessage, // hoặc contact.message
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.call, color: Colors.green),
      ),
    );
  }
}
