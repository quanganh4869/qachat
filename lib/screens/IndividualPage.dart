import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;

  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool showEmojiPicker = false;

  @override
  void initState() {
    super.initState();

    // Lắng nghe khi focus vào textfield thì tắt emoji picker
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 203, 203),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back, color: Colors.white),
              const SizedBox(width: 2),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: widget.chatModel.isGroup
                    ? SvgPicture.asset(
                        'assets/group.svg',
                        width: 30,
                        height: 30,
                      )
                    : SvgPicture.asset(
                        'assets/person.svg',
                        width: 30,
                        height: 30,
                      ),
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
                widget.chatModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Last seen: ${widget.chatModel.time}",
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.video_call), onPressed: () {}),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: "View Contact",
                  child: Text("View Contact"),
                ),
                PopupMenuItem(value: "Media files", child: Text("Media files")),
                PopupMenuItem(
                  value: "Whatsapp Web",
                  child: Text("Whatsapp Web"),
                ),
                PopupMenuItem(value: "Search", child: Text("Search")),
                PopupMenuItem(
                  value: "Mute Notifications",
                  child: Text("Mute Notifications"),
                ),
                PopupMenuItem(value: "Wallpaper", child: Text("Wallpaper")),
              ];
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          if (showEmojiPicker) {
            setState(() {
              showEmojiPicker = false;
            });
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Column(
          children: [
            Expanded(child: ListView()),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context, 
                              builder: (builder) => 
                              bottomSheet());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {},
                        ),
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
            if (showEmojiPicker) emojiSelect(),
          ],
        ),
      ),
    );
  }
  Widget bottomSheet(){
    return Container(
      height: 200,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.image, color: Colors.teal),
            title: const Text("Photo & Video Library"),
            onTap: () {
              // Handle photo and video library
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy, color: Colors.teal),
            title: const Text("Document"),
            onTap: () {
              // Handle document
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.teal),
            title: const Text("Location"),
            onTap: () {
              // Handle location
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone, color: Colors.teal),
            title: const Text("Contact"),
            onTap: () {
              // Handle contact
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
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
    );
  }
}
