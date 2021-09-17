import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:timepass/Widgets/videoStory.dart';
import 'package:video_player/video_player.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  PageController pageController = PageController(initialPage: 0);
  bool ontap = true;
  final StoryController controller = StoryController();
  Widget chatSections(double height, double width, String title,
      String subtitle, String imagePath, String time, bool notify) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(
              0,
              0,
              0,
              0.8,
            ),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        trailing: Container(
          child: Column(children: [
            SizedBox(
              height: height * 0.015,
            ),
            notify
                ? CircleAvatar(
                    radius: 9,
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(255, 94, 25, 1),
                  )
                : SizedBox(
                    height: height * 0.02,
                  ),
            Container(
              margin: EdgeInsets.only(top: height * 0.008),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.8,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  var sampleUsers = [
    UserModel([
      StoryModel("assets/images/s4.jpg", "Image", "1"),
    ], "ABC", "assets/images/profileImage.png"),
    //https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4

    UserModel(
      [
        StoryModel("assets/images/s5.jpg", "Image", "1"),
        StoryModel("assets/images/s7.jpg", "Image", "1"),
        StoryModel("assets/images/s2.jpg", "Image", "1"),
        StoryModel("assets/images/s8.jpg", "Image", "1"),
      ],
      "Akshay",
      "assets/images/profileImage.png",
    ),
    UserModel([
      StoryModel("assets/images/s4.jpg", "Image", "1"),
    ], "Xyz", "assets/images/profileImage.png"),
    UserModel([
      StoryModel("assets/images/s8.jpg", "Image", "1"),
      StoryModel("assets/images/s9.jpg", "Image", "1"),
      StoryModel("assets/images/s3.jpg", "Image", "1"),
    ], "Hydra Clan", "assets/images/profileImage.png"),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Duration duration = Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Stories",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: 3,
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          // Align(
                          //     alignment: Alignment.centerRight,
                          //     heightFactor: 1,
                          //     child: GestureDetector(
                          onTapDown: (details) {
                            controller.pause();
                          },
                          onTapCancel: () {
                            controller.play();
                          },
                          onTapUp: (details) {
                            // if debounce timed out (not active) then continue anim

                            controller.play();
                          },

                          child: StoryView(
                            onComplete: () {
                              if (i == 2) {
                                Navigator.pop(context);
                              } else {
                                pageController.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              }
                            },
                            storyItems: [
                              StoryItem.text(
                                title: "Hello",
                                backgroundColor: Colors.red,
                              ),
                              StoryItem(
                                StoryWidget(
                                  widget: FinalWidgetStoryVideo(
                                    controller: controller,
                                    url:
                                        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                  ),
                                  controller: controller,
                                ),
                                duration: Duration(seconds: 10),
                              ),
                              StoryItem(
                                  StoryWidget(
                                    widget: Image.asset("assets/images/s8.jpg",
                                        fit: BoxFit.fill),
                                    controller: controller,
                                  ),
                                  duration: Duration(seconds: 10)),
                              StoryItem(
                                  StoryWidget(
                                    widget: Image.asset("assets/images/s9.jpg",
                                        fit: BoxFit.fill),
                                    controller: controller,
                                  ),
                                  duration: Duration(seconds: 10)),
                              StoryItem(
                                  StoryWidget(
                                    widget: Image.asset("assets/images/s5.jpg",
                                        fit: BoxFit.fill),
                                    controller: controller,
                                  ),
                                  duration: Duration(seconds: 10)),
                              StoryItem(
                                  StoryWidget(
                                    widget: Image.asset("assets/images/s6.jpg",
                                        fit: BoxFit.fill),
                                    controller: controller,
                                  ),
                                  duration: Duration(seconds: 10)),
                            ],
                            inline: false,
                            progressPosition: ProgressPosition.top,
                            repeat: false,
                            controller: controller,
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.centerLeft,
                    heightFactor: 1,
                    child: SizedBox(
                        child: GestureDetector(onTap: () {
                          controller.previous();
                        }),
                        width: 70),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    heightFactor: 1,
                    child: SizedBox(
                        child: GestureDetector(onTap: () {
                          controller.next();
                        }),
                        width: 70),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.05,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/profileImage.png",
                        ),
                      ),
                      title: Text(
                        "Waggles",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl, this.typeOfMedia, this.storyid);
  final String typeOfMedia;
  final String imageUrl;
  final String storyid;
}

class StoryVideo extends StatefulWidget {
  final String? url;
  final bool? ontap;
  StoryVideo({
    this.url,
    this.ontap,
  });

  @override
  _StoryVideoState createState() => _StoryVideoState();
}

class _StoryVideoState extends State<StoryVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(
      widget.url!,
    )..initialize().then((value) {
        setState(() {});
        controller.play();
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: 1,
              child: VideoPlayer(
                controller,
              ),
            )
          : Container(),
    );
  }
}

class StoryWidget extends StatefulWidget {
  final Widget? widget;
  final StoryController? controller;
  final String? id;
  StoryWidget({this.widget, this.controller, this.id});

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  bool ontap = true;
  Widget chatSections(double height, double width, String title,
      String subtitle, String imagePath, String time, bool notify) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(
              0,
              0,
              0,
              0.8,
            ),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        trailing: Container(
          child: Column(children: [
            SizedBox(
              height: height * 0.015,
            ),
            notify
                ? CircleAvatar(
                    radius: 9,
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(255, 94, 25, 1),
                  )
                : SizedBox(
                    height: height * 0.02,
                  ),
            Container(
              margin: EdgeInsets.only(top: height * 0.008),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.8,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.widget!,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(38, 203, 255, 1),
                                Color.fromRGBO(105, 128, 253, 1),
                              ])),
                          height: height * 0.11,
                          width: width * 0.12,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ontap = false;
                            });
                            widget.controller!.pause();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(255, 179, 79, 1),
                                  Color.fromRGBO(226, 134, 14, 1),
                                ])),
                            height: height * 0.11,
                            width: width * 0.12,
                            alignment: Alignment.center,
                            child: Icon(
                              EvaIcons.messageCircle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          height: height * 0.11,
                          width: width * 0.12,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        ontap
            ? Container()
            : Container(
                height: height * 0.32,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ontap = true;
                          });
                          widget.controller!.play();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: width * 0.02, top: height * 0.01),
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.cancel,
                          ),
                        ),
                      ),
                      chatSections(
                          height,
                          width,
                          "Swetha",
                          "Hello karthik..... how are you",
                          "assets/images/Ellipse 8.png",
                          "7:44 am",
                          false),
                      chatSections(
                          height,
                          width,
                          "Swetha",
                          "Hello karthik..... how are you",
                          "assets/images/Ellipse 8.png",
                          "7:44 am",
                          false),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            constraints:
                                BoxConstraints(minHeight: height * 0.07),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              left: width * 0.04,
                              right: width * 0.025,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.01),
                            child: Container(
                              child: TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write a message",
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(124, 124, 124, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    suffixIcon: Container(
                                      margin: EdgeInsets.all(height * 0.007),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(235, 235, 235, 1),
                                      ),
                                      height: height * 0.05,
                                      width: width * 0.05,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.send,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ]),
              )
      ],
    );
  }
}
