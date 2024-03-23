import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:dara_app/Firebase/Utils/Provider.dart';
import 'package:dara_app/screens/homepage/editPost.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.value["user_object"]['posts'].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 7.0, mainAxisSpacing: 7.0),
            itemBuilder: (BuildContext context, int index) {
              return (provider.value["user_object"]['posts'][index]["media"] ==
                          "null" ||
                      provider.value["user_object"]['posts'][index]["media"] ==
                          "[]")
                  ? SizedBox()
                  : categorizePost(json.decode(provider
                                    .value["user_object"]['posts'][index]
                                        ["media"]
                                    .toString()
                                    .replaceAll('\\', ''))[0]) !=
                          "image"
                      ? Builder(builder: (context) {
                          Future<dynamic> generateVideoThumbnail(
                              String videoPath) async {
                            final thumbnail =
                                await VideoThumbnail.thumbnailData(
                              video: videoPath,
                              imageFormat: ImageFormat.PNG,
                              maxWidth: 300, // Adjust the width as needed
                              maxHeight: 290,
                              quality:
                                  100, // Adjust the quality (0 - 100) as needed
                            );
                            return thumbnail;
                          }

                          return FutureBuilder<dynamic>(
                            future: generateVideoThumbnail(json.decode(provider
                                .value["user_object"]['posts'][index]["media"]
                                .toString()
                                .replaceAll('\\', ''))[0]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                final image = Image.memory(snapshot.data!);
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPost(
                                                  mediaType: "video",
                                                  mediaPath: json.decode(
                                                      provider
                                                          .value["user_object"]
                                                              ['posts'][index]
                                                              ["media"]
                                                          .toString()
                                                          .replaceAll(
                                                              '\\', ''))[0],
                                                  type: "video",
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 290,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 290,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: image.image,
                                                    fit: BoxFit.cover),
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
                        })
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: 250,
                              child: CachedNetworkImage(
                                imageUrl: json.decode(provider
                                    .value["user_object"]['posts'][index]
                                        ["media"]
                                    .toString()
                                    .replaceAll('\\', ''))[0],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 290,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey),
                                fit: BoxFit.cover,
                              )));
            },
          ),
        ),
      ),
    );
  }
}
