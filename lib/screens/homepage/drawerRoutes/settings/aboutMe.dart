import '../../../../main.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final aboutMeController = TextEditingController();

  @override
  void initState() {
    aboutMeController.text =
        '''Hey there! I'm Michael, your friendly neighborhood laundry attendant and the proud owner of Sparkleen. I’m passionate about everything laundry-related, and I can't wait to share my expertise and love for clean, fresh-smelling clothes with you!

As a lifelong enthusiast of all things clean and tidy, I decided to turn my passion into a full-fledged laundry venture. With years of experience in the industry, I've honed my skills in the art of laundry, from battling stubborn stains to creating laundry masterpieces that leave my customers in awe. I believe that laundry is not just a chore; it's a chance to bring joy and comfort to people's lives, one freshly laundered garment at a time.

My mission is simple: to redefine the way you experience laundry services. I aim to transform the mundane chore of washing clothes into an enjoyable and hassle-free experience. My laundry is not just a place to get your clothes cleaned; it's a place to connect, relax, and be part of a vibrant laundry-loving community. I take great pride in offering top-notch service, meticulous attention to detail, and a commitment to exceeding your expectations''';
    super.initState();
  }

// @override
// void dispose() {
// super.dispose();
// _controller.dispose();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "About Me",
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
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              // Bio
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Me",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0XFFE5E7EB))),
                        child: TextFormField(
                          // focusNode: textNode,
                          onChanged: (value) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: true,
                          minLines: null,
                          controller: aboutMeController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide
                                  .none, // Remove the border when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide
                                  .none, // Remove the border when enabled
                            ),
                            hintText: "Add a few words about yourself",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () {
                  Navigator.pop(context);

                  //will save this parameter to state management later
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  decoration: BoxDecoration(
                      color: constants.appMainColor,
                      borderRadius: BorderRadius.circular(200)),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
