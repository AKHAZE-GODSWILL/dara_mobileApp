import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 40,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0
            ),
            itemBuilder: (BuildContext context, int index){
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: 250,
                      child: Image.asset("assets/posts.png",
                      fit: BoxFit.cover,
                      )));
            },
          ),
        ),
      ),
    );
  }
}
