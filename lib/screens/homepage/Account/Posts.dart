import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
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
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: 250,
                      child: CachedNetworkImage(
                        imageUrl: json.decode(provider.value["user_object"]
                                ['posts'][index]["media"]
                            .toString()
                            .replaceAll('\\', ''))[0],
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person, size: 50, color: Colors.grey),
                        fit: BoxFit.cover,
                      )));
            },
          ),
        ),
      ),
    );
  }
}
