import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whatapps/Pages/CameraPage.dart';
import 'package:whatapps/Pages/Chatpage.dart';

class Homescreens extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Homescreens({Key? key, required this.cameras}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreens> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whatsapp Clone"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                 PopupMenuItem(value: "New Group", child: Text("New Group")),
                 PopupMenuItem(value: "New Broadcast", child: Text("New Broadcast")),
                 PopupMenuItem(value: "Whatsapp Web", child: Text("Whatsapp Web")),
                 PopupMenuItem(value: "Starred Messages", child: Text("Starred Messages")),
                 PopupMenuItem(value: "Settings", child: Text("Settings")),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs:  [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "Chats"),
            Tab(text: "Status"),
            Tab(text: "Calls"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
            CameraPage(cameras: widget.cameras), // ✅ cameras truyền đúng
           Chatpage(),
           Center(child: Text("Status")),
           Center(child: Text("Calls")),
        ],
      ),
    );
  }
}
