import 'package:flutter/material.dart';


class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, required this.name, required this.icon}) : super(key: key);

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blueAccent,
        child: Icon(icon, size: 36),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
