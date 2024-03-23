import 'dart:io';
import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dara_app/models/messageModel.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/callsScreen.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chat/messageWidget.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chat/recordingVisualizer.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/ViewClientAccount.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderAccount.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.target_id}) : super(key: key);
  final target_id;
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _controller = new TextEditingController();
  FlutterSoundRecorder? _soundRecorder;

  bool show = false;
  bool isRecorderInit = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  List<MessageModel> messageList = [
    MessageModel(
        message: "Hello",
        type: "destination",
        mediaType: "none",
        filePath: "",
        time: DateTime.now().toString().substring(10, 16)),
    MessageModel(
        message: "Welcome to Dara. Lets Chat!",
        type: "destination",
        mediaType: "none",
        filePath: "",
        time: DateTime.now().toString().substring(10, 16)),
  ];
  ScrollController _scrollController = ScrollController();

  List<int> durations = [900, 700, 800, 500, 300, 700, 900, 400, 800, 600];
  File? readyUpload;
  String _filePath = "";
  int fileCounter = 0;
  String recordingPath = "";

  initRecordingPath() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    recordingPath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
  }

  @override
  void initState() {
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    initRecordingPath();
    super.initState();
  }

  @override
  void dispose() {
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chatBody();
  }

  Widget chatBody() {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      // I'll run a request in the init state to get me the names of the receiver or the person I am chatting with
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Text("")),
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    height: 42,
                    width: 42,
                    child: Container(
                        child: Transform.scale(
                            scale: 0.5,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 30,
                              ),
                            )))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          (provider.userType == "serviceProvider")
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewClientAccount()))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceProviderAccount(
                                            user: widget.target_id,
                                          )));
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/profile.png"),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daniel Smith",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 36,
                width: 36,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return CallsScreen(
                                  target_id: widget.target_id,
                                  target_name: "",
                                  target_img: "");
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    },
                    icon: Icon(
                      PhosphorIcons.phone,
                      color: Colors.black,
                    ))),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                var currentItem = messageList[index];

                if (currentItem == messageList.length) {
                  return Container(
                    height: 70,
                  );
                }

                return Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: MessageCard(message: currentItem));
              },
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (isRecording)
                                ? Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    // color: Colors.red,
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        // color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List<Widget>.generate(
                                              10,
                                              (index) => RecordingVisualizer(
                                                  animDuration:
                                                      durations[index])),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.83,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(200)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.63,
                                                height: 48,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    setState(() {});
                                                  },
                                                  controller: _controller,
                                                  focusNode: focusNode,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  expands: true,
                                                  minLines: null,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Type message here",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              // handles the action performed anytime you press the send button
                                              onPressed: () {
                                                sendPicture(context);
                                              },

                                              icon: Icon(
                                                Icons.photo_outlined,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                            IconButton(
                              // handles the action performed anytime you press the send button
                              onPressed: () async {
                                if (_controller.text != "") {
                                  FocusScope.of(context).unfocus();
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  sendMessage(_controller.text, '', '', "");
                                  _controller.text = "";
                                } else {
                                  // var tempDir = await getTemporaryDirectory();
                                  // var path = "${tempDir.path}/flutter_sound.aac";

                                  if (isRecorderInit == false) {
                                    return;
                                  }

                                  if (isRecording) {
                                    await _soundRecorder!.stopRecorder();

                                    sendMediaMessage(
                                        type: "source",
                                        mediaType: "sound recording",
                                        mediaPath: recordingPath);
                                    initRecordingPath();
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>  CustomAudioPlayer(audioPath: path)));
                                  } else {
                                    await _soundRecorder!
                                        .startRecorder(toFile: recordingPath);
                                  }

                                  setState(() {
                                    isRecording = !isRecording;
                                  });
                                }
                              },

                              icon: (_controller.text.isNotEmpty)
                                  ? Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    )
                                  : (isRecording)
                                      ? Icon(Icons.close)
                                      : Icon(
                                          Icons.mic_none_outlined,
                                          color: Colors.black,
                                        ),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  sendPicture(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickFile();

                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: constants.appMainColor,
                            child: Icon(Icons.file_copy),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "File",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getImageCamera();

                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: constants.appMainColor,
                            child: Icon(Icons.camera),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getMediaGallery();
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: constants.appMainColor,
                            child: Icon(Icons.image),
                          ),
                          SizedBox(height: 5),
                          Text("Gallery",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getMediaGallery() {
    ImagePicker().pickMultipleMedia().then((selectedmedia) {
      if (selectedmedia.isEmpty) return;

      // readyUpload = File(selectedmedia[0].path);

      selectedmedia.forEach((element) {
        setState(() {
          openMedia(filePath: element.path, type: "source");
        });
      });
    });
  }

  getImageCamera() {
    ImagePicker().pickImage(source: ImageSource.camera).then((selectedImage) {
      if (selectedImage == null) return;

      // readyUploadImage = File(selectedImage.path);

      setState(() {
        openMedia(filePath: selectedImage.path, type: "source");
        // filesInfo[index]["path"] = selectedImage.path!;
        // filesInfo[index]["type"] =  "photo";
      });
    });
  }

  getVideoGallery() {
    ImagePicker().pickVideo(source: ImageSource.gallery).then((selectedVideo) {
      if (selectedVideo == null) return;

      readyUpload = File(selectedVideo.path);
      setState(() {});
    });
  }

  void sendMessage(String message, sourceId, targetId, String filePath) {
    // The send message function adds the messages to the list and also sends them through the socket
    // on calling the sendMessage method, the setMessage function sets the type of the message to be
    // Source before saving in the list
    setMessage("source", message, filePath);
  }

  // Forces all the messages to take
  void setMessage(String type, String message, String mediaPath) {
    MessageModel messagesModel = MessageModel(
        message: message,
        type: type,
        filePath: mediaPath,
        mediaType: "none",
        time: DateTime.now().toString().substring(10, 16));
    addMessage(messagesModel);
  }

  // Forces all the messages to take
  void setMediaMessage(
      String type, String mediaType, String message, String mediaPath) {
    MessageModel messagesModel = MessageModel(
        message: message,
        type: type,
        filePath: mediaPath,
        mediaType: mediaType,
        time: DateTime.now().toString().substring(10, 16));
    addMessage(messagesModel);
  }

  addMessage(MessageModel msg) {
    messageList.add(msg);
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Mic permission not allowed");
    }

    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  // Forces all the messages to take
  void sendMediaMessage(
      {required String type, required mediaType, required String mediaPath}) {
    setMediaMessage(type, mediaType, "", mediaPath);
  }

  void openMedia({required String filePath, required String type}) {
    if (filePath.endsWith('.jpg') ||
        filePath.endsWith('.jpeg') ||
        filePath.endsWith('.png') ||
        filePath.endsWith('.gif') ||
        filePath.endsWith('.bmp') ||
        filePath.endsWith('.tif') ||
        filePath.endsWith('.tiff') ||
        filePath.endsWith('.webp') ||
        filePath.endsWith('.svg') ||
        filePath.endsWith('.heic') ||
        filePath.endsWith('.heif')) {
      // It's an image file
      // Render it using an Image widget

      sendMediaMessage(type: type, mediaType: "image", mediaPath: filePath);
    } else if (filePath.endsWith('.mp4') ||
        filePath.endsWith('.avi') ||
        filePath.endsWith('.mov') ||
        filePath.endsWith('.mkv') ||
        filePath.endsWith('.wmv') ||
        filePath.endsWith('.flv') ||
        filePath.endsWith('.webm') ||
        filePath.endsWith('.3gp') ||
        filePath.endsWith('.mpeg') ||
        filePath.endsWith('.mpg') ||
        filePath.endsWith('.ogg')) {
      // It's a video file
      // Render it using a VideoPlayer widget

      sendMediaMessage(type: type, mediaType: "video", mediaPath: filePath);
    } else {
      // Handle other file types as needed
    }
  }

  Future<void> _pickFile() async {
    await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "pdf",
      "doc",
      "docX",
      "xls",
      "xlsx",
      "ppt",
      "pptx",
      "txt", //
      "rtf",
      "csv", //
      "htm",
      "html", //
      "xml",
      "json",
      "md",
      "markdown",
      "tex",
      "odt",
      "ods", //
      "odp"
    ]).then((result) {
      if (result != null) {
        _filePath = result.files.single.path!;
        result.files.single.name;

        setState(() {
          sendMediaMessage(
              type: "source", mediaType: "document", mediaPath: _filePath);
        });
      }
    });
  }
}
