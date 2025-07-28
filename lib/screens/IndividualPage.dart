import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatapps/Custom/ReplyCard.dart';
import 'package:whatapps/Model/ChatModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatapps/Custom/OwnMessageCard.dart';

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

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Scaffold(
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
                      child: (widget.chatModel.isGroup ?? false)
                          ? SvgPicture.asset('assets/group.svg', width: 30, height: 30)
                          : SvgPicture.asset('assets/person.svg', width: 30, height: 30),
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
                IconButton(icon: const Icon(Icons.call), onPressed: () {}),
                IconButton(icon: const Icon(Icons.video_call), onPressed: () {}),
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return const [
                      PopupMenuItem(value: "View Contact", child: Text("View Contact")),
                      PopupMenuItem(value: "Media files", child: Text("Media files")),
                      PopupMenuItem(value: "Whatsapp Web", child: Text("Whatsapp Web")),
                      PopupMenuItem(value: "Search", child: Text("Search")),
                      PopupMenuItem(value: "Mute Notifications", child: Text("Mute Notifications")),
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
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height -140,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              OwnMessageCard(), 
                              ReplyCard(),
                            ],
                          ),
                        ),
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
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomSheet(context),
                                  );
                                },
                              ),
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
                  if (showEmojiPicker) emojiSelect(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 20,
            runSpacing: 20,
            children: [
              iconCreation(Icons.insert_drive_file, Colors.indigo, "Document"),
              iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
              iconCreation(Icons.image, Colors.purple, "Gallery"),
              iconCreation(Icons.headset, Colors.orange, "Audio"),
              iconCreation(Icons.location_on, Colors.green, "Location"),
              iconCreation(Icons.person, Colors.blue, "Contact"),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, size: 29, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 14)),
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
