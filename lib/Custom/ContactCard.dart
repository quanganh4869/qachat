import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blueGrey[300],
            child: contact.isGroup == true
                ? ClipOval(
                    child: SvgPicture.asset(
                      'assets/images/groups.png',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.person, size: 35, color: Colors.white),
          ),
          contact.selected?
          Positioned(
            bottom: 2,
            right: 2,
            child: CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 11,
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
          ):Container(),
        ],
      ),
      title: Text(
        contact.name ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.currentMessage ?? '',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
