import 'package:flutter/material.dart';
import 'package:whatapps/Pages/Chatpage.dart';

class Homescreens extends StatefulWidget {
  const Homescreens({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreens> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp Clone "),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected:(value){
              print(value);
            },
            itemBuilder: (BuildContext context) {                  
            return [
              PopupMenuItem<String>(
                value: "New Group",
                child: Text("New Group"),
              ),
              PopupMenuItem<String>(
                value: "New Broadcast",
                child: Text("New Broadcast"),
              ),
              PopupMenuItem<String>(
                value: "Whatsapp Web",
                child: Text("Whatsapp Web"),
              ),
              PopupMenuItem<String>(
                value: "Starred Messages",
                child: Text("Starred Messages"),
              ),
              PopupMenuItem<String>(
                value: "Settings",
                child: Text("Settings"),
              ),
            ];
          }, ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white, 
          tabs: [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(
              text: "Chats"
              ),
            Tab(
              text: "Status"
              ),
            Tab(
              text: "Calls"
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Center(child: Text("Camera")),
          Center(child: Chatpage()),
          Center(child: Text("Status")),
          Center(child: Text("Calls")),
        ],
      ),
    );
  }
}
