import 'dart:io';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dara_app/screens/homepage/editPost.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key, required this.backToHome}) : super(key: key);
  final Function backToHome;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // late VideoPlayerController videoPlayerController;
  final _captionController = TextEditingController();
  List<XFile> mediaFiles = [];
  String imgPath = "";
  String imgExt = "";
  File? readyUploadImage;
  bool hasImg = false;
  bool isLoading = false;

  // String? whoCanSeePost = "Anyone";
  // var viewList = [
  //   'Anyone',
  //   "Friends",
  //   "Family",
  // ];

  int photoCount = 0;
  int videoCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Container(),
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(0, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    height: 42,
                    width: 42,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(100),
                    //     border:
                    //     Border.all(color: Colors.black12)),
                    child: IconButton(
                      onPressed: () {
                        widget.backToHome(index: 0);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Create Post",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  isLoading = true;
                });

                createPost(
                        imageFiles: mediaFiles,
                        body: _captionController.text.trim(),
                        token: provider.sp_token!)
                    .then((value) {
                  print(
                      "The final Value of what was resulted from the request was :$value");

                  if (value["status"] == true) {
                    ///// Navigation.push to the OTP screen
                    // Navigator.pop(context);
                    mywidgets.displayToast(msg: "Successful");
                    widget.backToHome(index: 0);
                  } else if (value["status"] == "Network Error") {
                    mywidgets.displayToast(
                        msg:
                            "Network Error. Check your Network Connection and try again");
                  } else {
                    mywidgets.displayToast(msg: value["message"]);
                  }

                  setState(() {
                    isLoading = false;
                  });
                });
              },
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0XFFF3F4F6),
                    borderRadius: BorderRadius.circular(200)),
                child: Center(
                  child: (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          "Post",
                          style:
                              TextStyle(color: Color(0XFF6B7280), fontSize: 14),
                        ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: (provider.userType == "serviceProvider")
                            ? provider.sp_profile_image!
                            : provider.client_profile_image!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person, size: 100, color: Colors.white),
                      )),
                  // Container(
                  //   height: 48,
                  //   width: 80,
                  //   // decoration: BoxDecoration(
                  //   //   borderRadius: BorderRadius.circular(8),
                  //   //   border: Border.all(
                  //   //     width: 1,
                  //   //     color: Color(0XFFE5E7EB)
                  //   //   )
                  //   // ),
                  // child: DropdownButtonHideUnderline(
                  //   child: DropdownButton2(
                  //     icon: Icon(
                  //       Icons.arrow_drop_down,
                  //       color: Colors.black38,
                  //     ),
                  //     hint: Text(
                  //       '',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.black54,
                  //       ),
                  //     ),
                  //     items: viewList
                  //         .map((item) =>
                  //             DropdownMenuItem<String>(
                  //               value: item,
                  //               child: Text(
                  //                 item,
                  //                 style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 14),
                  //               ),
                  //             ))
                  //         .toList(),
                  //     value: whoCanSeePost,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         whoCanSeePost = value as String;
                  //       });
                  //     },
                  //     buttonHeight: 40,
                  //     buttonWidth: 140,
                  //     itemHeight: 40,
                  //   ),
                  // ),
                  // ),

                  // Row(
                  //   children: [
                  //     Text("total media: ${mediaFiles.length}"),
                  //     // Text("total videos: ${videoCount}"),
                  //     Text("total photos: ${photoCount}"),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Container(
                height: 100,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   border: Border.all(
                //     width: 1,
                //     color: Color(0XFFE5E7EB)
                //   )
                // ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  // focusNode: textNode,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  controller: _captionController,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide.none, // Remove the border when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide.none, // Remove the border when enabled
                      ),
                      hintText: "Give your post an interesting caption",
                      hintStyle: GoogleFonts.inter(
                          fontSize: 14, color: Color(0XFF6B7280))),
                ),
              ),
            ),
          ),
          (imgPath.isNotEmpty)
              ? Container(
                  height: 360,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          3, // Adjust the number of columns as needed
                    ),
                    itemCount: mediaFiles
                        .length, // Replace with the length of your data
                    itemBuilder: (BuildContext context, int index) {
                      return customMediaWidget(
                          filePath: mediaFiles[index].path, index: index);
                    },
                  ))
              : SizedBox(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 41,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // selectMultiImages();
                      (photoCount == 30)
                          ? Fluttertoast.showToast(
                              msg: "You can only post up to 30 photos")
                          : getImageGallerys();
                      print(mediaFiles.length);
                    },
                    child: Container(
                      width: 120,
                      height: 41,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          color: Color(0XFFF3F4F6),
                          borderRadius: BorderRadius.circular(200)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              child:
                                  SvgPicture.asset("assets/svg/post-image.svg"),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Image",
                              style: TextStyle(
                                  color: Color(0XFF6B7280), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      (videoCount == 20)
                          ? Fluttertoast.showToast(
                              msg: "You can only post up to 20 videos")
                          : getVideoGallery();
                    },
                    child: Container(
                      width: 120,
                      height: 41,
                      decoration: BoxDecoration(
                          color: Color(0XFFF3F4F6),
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(200)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              child:
                                  SvgPicture.asset("assets/svg/post-video.svg"),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Video",
                              style: TextStyle(
                                  color: Color(0XFF6B7280), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  customMediaWidget({required String filePath, required index}) {
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
      return InkWell(
        onTap: () {
          print(photoCount);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPost(
                        mediaType: "image",
                        mediaPath: filePath,
                        index: index,
                        deletePost: deletePostFromPostPage,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(filePath), fit: BoxFit.cover),
            ),
          ),
        ),
      );
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
      return FutureBuilder<dynamic>(
        future: generateVideoThumbnail(filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final image = Image.memory(snapshot.data!);
            return InkWell(
              onTap: () {
                print(videoCount);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPost(
                              mediaType: "video",
                              mediaPath: filePath,
                              index: index,
                              deletePost: deletePostFromPostPage,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: image.image, fit: BoxFit.cover),
                          )),
                      Center(
                        child: Icon(
                          Icons.play_circle,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                // child: CircularProgressIndicator()
              ),
            ); // You can display a loading indicator here.
          }
        },
      );
    } else {
      // Handle other file types as needed
    }
  }

  deletePostFromPostPage({required index, required mdType}) {
    setState(() {
      mediaFiles.removeAt(index);

      if (mdType == "image") {
        photoCount--;
      } else if (mdType == "video") {
        videoCount--;
      }
    });
  }

  getImageGallery() {
    ImagePicker().pickMultiImage().then((selectedImage) {
      if (selectedImage.isNotEmpty) {
        mediaFiles.addAll(selectedImage);
      }

      setState(() {
        hasImg = true;
      });
    });
  }

  getImageGallerys() {
    ImagePicker().pickMultiImage().then((selectedImage) {
      if (selectedImage == null) return;

      readyUploadImage = File(selectedImage[0].path);

      print(readyUploadImage!.path);

      setState(() {
        imgPath = readyUploadImage!.path;
        imgExt = imgPath.split(".").last;
        hasImg = true;

        if (selectedImage.isNotEmpty) {
          (photoCount < 30)
              ? selectedImage.forEach((image) {
                  (photoCount < 30) ? mediaFiles.add(image) : ();
                  (photoCount < 30) ? photoCount++ : ();
                })
              : ();

          /////////
          ///
          /// if photocount is more than 30, the Toast should be triggered
        }
      });
    });
  }

  Future<void> getVideoGallery() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo == null) return;

    final videoPath = File(pickedVideo.path);

    print(videoPath.path);

    setState(() {
      imgPath = videoPath.path;
      imgExt = imgPath.split(".").last;
      hasImg = true;
      (videoCount < 20) ? mediaFiles.add(pickedVideo) : ();
      (videoCount < 20) ? videoCount++ : ();
    });
  }

  Future<dynamic> generateVideoThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200, // Adjust the width as needed
      quality: 25, // Adjust the quality (0 - 100) as needed
    );

    return thumbnail;
  }
}
