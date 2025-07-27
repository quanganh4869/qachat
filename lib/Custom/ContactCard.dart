import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,  
        height: 53,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey[300],
              child: (contact.isGroup ?? false)
                  ? SvgPicture.asset(
                      'assets/images/groups.svg', // Đảm bảo file SVG có trong assets
                      width: 40,
                      height: 40,
                    )
                  : const Icon(Icons.person, size: 35, color: Colors.white),
            ),
            if (contact.selected ?? false)
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
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
