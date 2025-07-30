import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/screens/IndividualPage.dart';
import 'package:camera/camera.dart';

class Customcard extends StatelessWidget {
  const Customcard({
    Key? key,
    required this.chatModel,
    required this.cameras,
  }) : super(key: key);

  final ChatModel chatModel;
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              cameras: cameras, // ✅ Truyền cameras sang IndividualPage
            ),
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey.shade200,
          child: SvgPicture.asset(
            chatModel.isGroup == true
                ? 'assets/images/group.png'
                : 'assets/images/person.png',
            width: 50,
            height: 50,
          ),
        ),
        title: Text(
          chatModel.name ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.done_all, color: Colors.green, size: 16),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                chatModel.currentMessage ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Text(chatModel.time ?? ''),
      ),
    );
  }
}
