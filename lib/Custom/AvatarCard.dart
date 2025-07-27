import 'package:flutter/material.dart';
import 'package:whatapps/Model/ChatModel.dart';

class AvatarCard extends StatelessWidget {
  final ChatModel contact;

  const AvatarCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blueGrey[300],
                child: const Icon(Icons.person, size: 35, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11,
                  child: const Icon(Icons.clear, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            contact.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
