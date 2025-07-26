import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:whatapps/screens/IndividualPage.dart';
class Customcard extends StatelessWidget {
  const Customcard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
            ),
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: SvgPicture.asset(
            chatModel.isGroup
                ? 'assets/images/group.png'
                : 'assets/images/person.png',
            width: 50,
            height: 50,
          ),
        ),
        title: Text(
          chatModel.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.done_all, color: Colors.green, size: 16),
            SizedBox(width: 3),
            Text(chatModel.currentMessage ),
          ],
        ),
        trailing: Text(chatModel.time),
      ),
    );
  }
}