import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatapps/Custom/ReplyCard.dart';
import 'package:whatapps/Custom/OwnMessageCard.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final List<CameraDescription> cameras;

  const IndividualPage({
    Key? key,
    required this.chatModel,
    required this.cameras,
  }) : super(key: key);

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late IO.Socket socket;

  bool showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    connectSocket();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  String getSocketUrl() {
    if (kIsWeb) {
      return "http://192.168.1.150:5000"; // IP LAN của bạn
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:5000";
    } else if (Platform.isIOS) {
      return "http://localhost:5000";
    } else {
      return "http://192.168.1.10:5000";
    }
  }

  void connectSocket() {
    String socketUrl = getSocketUrl();
    print("🔗 Connecting to $socketUrl");

    socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .setReconnectionDelay(5000)
          .build(),
    );

    socket.onConnect((_) => print("✅ Connected to $socketUrl"));
    socket.onConnectError((err) => print("❌ Connect Error: $err"));
    socket.onDisconnect((_) => print("🔌 Disconnected from server"));

    socket.connect();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    socket.dispose(); // Đóng socket khi thoát
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back, color: Colors.white),
              const SizedBox(width: 2),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: (widget.chatModel.isGroup ?? false)
                    ? Image.asset('assets/images/group.png', width: 30, height: 30)
                    : Image.asset('assets/images/person.png', width: 30, height: 30),
              ),
            ],
          ),
        ),
        title: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatModel.name ?? '',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "Last seen: ${widget.chatModel.time ?? ''}",
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
         
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/back.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    OwnMessageCard(),
                    ReplyCard(),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.emoji_emotions),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                showEmojiPicker = !showEmojiPicker;
                              });
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              focusNode: _focusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              ),
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 5, left: 2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        icon: const Icon(Icons.mic, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              if (showEmojiPicker)
                SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      setState(() {
                        _messageController.text += emoji.emoji;
                      });
                    },
                    config: const Config(
                      emojiViewConfig: EmojiViewConfig(emojiSizeMax: 32),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
