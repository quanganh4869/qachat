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

class _HomescreenState extends State<Homescreens> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Chatpage(cameras: widget.cameras),
      const Center(child: Text("Status")),
      const Center(child: Text("Community")),
      const Center(child: Text("Calls")),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whatsapp Clone"),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(cameras: widget.cameras),
                ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(value: "New Group", child: Text("New Group")),
                PopupMenuItem(value: "New Broadcast", child: Text("New Broadcast")),
                PopupMenuItem(value: "Whatsapp Web", child: Text("Whatsapp Web")),
                PopupMenuItem(value: "Starred Messages", child: Text("Starred Messages")),
                PopupMenuItem(value: "Settings", child: Text("Settings")),
              ];
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: "Status"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        ],
      ),
    );
  }
}
