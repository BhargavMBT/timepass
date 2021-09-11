import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:story_view/story_view.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Screens/PostAddScreen.dart';
import 'package:timepass/Screens/storiesScreen.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/Widgets/videoStory.dart';
import 'package:timepass/main.dart';
import 'package:http/http.dart' as http;

class YourStories extends StatefulWidget {
  const YourStories({Key? key}) : super(key: key);

  @override
  _YourStoriesState createState() => _YourStoriesState();
}

class _YourStoriesState extends State<YourStories> {
  @override
  void initState() {
    super.initState();
  }

  Future getStories() async {
    try {
      var url = Uri.parse('$weburl/stories/story/$userid');

      var response = await http.get(url, headers: {
        'x-access-token': xAccessToken!,
      });
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        throw Exception("something went wrong.");
      }
    } catch (e) {
      throw Exception("something went wrong.");
    }
  }

  Future deleteStories(String id, String imageUrl) async {
    try {
      var url = Uri.parse('$weburl/stories/delete/$id');

      var response = await http.delete(url, headers: {
        'x-access-token': xAccessToken!,
      });
      if (response.statusCode == 200) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        print(response.body);
        return response.body;
      } else {
        throw Exception("something went wrong.");
      }
    } catch (e) {
      throw Exception("something went wrong.");
    }
  }

  bool ontap = true;
  bool isloading = false;
  String? storyimageurl;
  final StoryController controller = StoryController();
  String? storyid;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        FutureBuilder(
          future: getStories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data);
              List<StoryItem> _list = [];
              data.forEach((element) {
                StoryItem item = element["type"] == "Video"
                    ? StoryItem(
                        YourStoryWidget(
                          imageurl: element["story"],
                          widget: FinalWidgetStoryVideo(
                            controller: controller,
                            url: element["story"],
                          ),
                          // Image.network(element["story"], fit: BoxFit.fill),
                          controller: controller,
                          id: element['_id'],
                        ),
                        duration: Duration(seconds: 20))
                    : StoryItem(
                        YourStoryWidget(
                          imageurl: element["story"],
                          widget: CachedNetworkImage(
                            imageUrl: element["story"],
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: circularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // Image.network(element["story"], fit: BoxFit.fill),
                          controller: controller,
                          id: element['_id'],
                        ),
                        duration: Duration(seconds: 10));
                _list.add(item);
              });
              // List<StoryModel> _story = [];
              // data.forEach((element) {
              //   StoryModel model =
              //       StoryModel(element["story"], "Image", element['_id']);
              //   _story.add(model);
              // });
              // List<UserModel> sampleUsers = [UserModel(_story, "", "")];

              // final story = sampleUsers[0].stories;
              return _list.isEmpty
                  ? PostAddScreen()
                  : Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        actions: [
                          IconButton(
                            onPressed: () {
                              controller.dispose();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return PostAddScreen();
                              }));
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          )
                        ],
                        title: Text(
                          "Your stories",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      body: Stack(children: [
                        Container(
                          child: GestureDetector(
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
                            child: Column(
                              children: [
                                Expanded(
                                  child: StoryView(
                                      onComplete: () {
                                        Navigator.pop(context);
                                      },
                                      inline: false,
                                      progressPosition: ProgressPosition.top,
                                      repeat: false,
                                      storyItems: _list,
                                      controller: controller),
                                  // StoryPageView(
                                  //   selected: ontap,
                                  //   initialPage: 0,
                                  //   indicatorPadding: EdgeInsets.only(
                                  //     top: height * 0.02,
                                  //     left: width * 0.015,
                                  //     right: width * 0.015,
                                  //   ),
                                  //   itemBuilder: (context, pageIndex, storyIndex) {
                                  //     return Stack(
                                  //       children: [
                                  //         Positioned.fill(
                                  //           child: Container(color: Colors.black),
                                  //         ),
                                  //         story[storyIndex].typeOfMedia == "Image"
                                  //             ? Positioned.fill(
                                  //                 child: Image.network(
                                  //                   story[storyIndex].imageUrl,
                                  //                   fit: BoxFit.fill,
                                  //                 ),
                                  //               )
                                  //             : Positioned.fill(
                                  //                 child: Container(),
                                  //               ),
                                  //       ],
                                  //     );
                                  //   },
                                  //   gestureItemBuilder:
                                  //       (context, pageIndex, storyIndex) {
                                  //     return ontap
                                  //         ? Align(
                                  //             alignment: Alignment.bottomRight,
                                  //             child: GestureDetector(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   ontap = false;
                                  //                   storyid =
                                  //                       story[storyIndex].storyid;
                                  //                   storyimageurl =
                                  //                       story[storyIndex].imageUrl;
                                  //                 });
                                  //               },
                                  //               child: Container(
                                  //                 margin: EdgeInsets.only(
                                  //                   right: width * 0.02,
                                  //                 ),
                                  //                 decoration: BoxDecoration(
                                  //                     shape: BoxShape.circle,
                                  //                     gradient:
                                  //                         LinearGradient(colors: [
                                  //                       Color.fromRGBO(
                                  //                           38, 203, 255, 1),
                                  //                       Color.fromRGBO(
                                  //                           105, 128, 253, 1),
                                  //                     ])),
                                  //                 height: height * 0.11,
                                  //                 width: width * 0.12,
                                  //                 alignment: Alignment.center,
                                  //                 child: Icon(
                                  //                   Icons.delete,
                                  //                   color: Colors.red,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //         : Container();
                                  //   },
                                  //   initialStoryIndex: (pageIndex) {
                                  //     return 0;
                                  //   },
                                  //   pageLength: sampleUsers.length,
                                  //   storyLength: (int pageIndex) {
                                  //     return _story.length;
                                  //   },
                                  //   onPageLimitReached: () {
                                  //     Navigator.pop(context);
                                  //   },
                                  // ),
                                ),
                                // ontap
                                //     ? Container()
                                //     : Container(
                                //         height: height * 0.1,
                                //         width: double.infinity,
                                //         color: Colors.white,
                                //         child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.start,
                                //             children: [
                                //               GestureDetector(
                                //                 onTap: () {
                                //                   setState(() {
                                //                     ontap = true;
                                //                   });
                                //                 },
                                //                 child: Container(
                                //                   margin: EdgeInsets.only(
                                //                       right: width * 0.02,
                                //                       top: height * 0.01),
                                //                   alignment: Alignment.topRight,
                                //                   child: Icon(
                                //                     Icons.cancel,
                                //                   ),
                                //                 ),
                                //               ),
                                //               Align(
                                //                   alignment: Alignment.bottomCenter,
                                //                   child: Container(
                                //                       padding: EdgeInsets.only(
                                //                         left: width * 0.04,
                                //                         right: width * 0.15,
                                //                       ),
                                //                       child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .spaceBetween,
                                //                         children: [
                                //                           Text(
                                //                               "Are you sure for delete the story?"),
                                //                           GestureDetector(
                                //                             onTap: () {
                                //                               if (storyid != null &&
                                //                                   storyimageurl !=
                                //                                       null) {
                                //                                 deleteStories(
                                //                                         storyid!,
                                //                                         storyimageurl!)
                                //                                     .then((value) {
                                //                                   setState(() {
                                //                                     _story.removeWhere(
                                //                                         (element) =>
                                //                                             element
                                //                                                 .storyid ==
                                //                                             storyid);
                                //                                     storyid = null;
                                //                                     ontap = true;
                                //                                     storyimageurl =
                                //                                         null;
                                //                                   });
                                //                                   Navigator.pushReplacement(
                                //                                       context,
                                //                                       MaterialPageRoute(builder:
                                //                                           (BuildContext
                                //                                               context) {
                                //                                     return MyApp();
                                //                                   }));
                                //                                 }).catchError((e) {
                                //                                   AuthService()
                                //                                       .errorDialog(
                                //                                     context,
                                //                                     "Something went wrong.",
                                //                                   );
                                //                                 });
                                //                               }
                                //                             },
                                //                             child: Text(
                                //                               "Delete",
                                //                               style: TextStyle(
                                //                                 color: Colors.red,
                                //                                 fontWeight:
                                //                                     FontWeight.w600,
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ))),
                                //             ]),
                                //       )
                              ],
                            ),
                          ),
                        ),
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
                            width: 70,
                            height: height * 0.5,
                          ),
                        ),
                      ]),
                    );
            } else {
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: circularProgressIndicator(),
              );
            }
          },
        ),
        isloading
            ? Center(
                child: circularProgressIndicator(),
              )
            : Container(),
      ],
    );
  }
}

class YourStoryWidget extends StatefulWidget {
  final Widget? widget;
  final String? id;
  final StoryController? controller;
  final String? imageurl;

  YourStoryWidget({
    this.widget,
    this.id,
    this.controller,
    this.imageurl,
  });

  @override
  _YourStoryWidgetState createState() => _YourStoryWidgetState();
}

class _YourStoryWidgetState extends State<YourStoryWidget> {
  Future deleteStories(String id, String imageUrl) async {
    try {
      var url = Uri.parse('$weburl/stories/delete/$id');

      var response = await http.delete(url, headers: {
        'x-access-token': xAccessToken!,
      });
      if (response.statusCode == 200) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        print(response.body);
        return response.body;
      } else {
        throw Exception("something went wrong.");
      }
    } catch (e) {
      throw Exception("something went wrong.");
    }
  }

  bool ontap = true;
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(widget.imageurl);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.widget!,
              ontap
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            ontap = false;
                            widget.controller!.pause();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: width * 0.02,
                          ),
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
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        ontap
            ? Container()
            : Container(
                height: height * 0.1,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.controller!.play();
                          setState(() {
                            ontap = true;
                          });
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
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.only(
                                left: width * 0.04,
                                right: width * 0.15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Are you sure for delete the story?"),
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.id != null &&
                                          widget.imageurl != null) {
                                        deleteStories(
                                                widget.id!, widget.imageurl!)
                                            .then((value) {
                                          setState(() {
                                            ontap = true;
                                          });
                                          Navigator.pop(context);
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(builder:
                                          //         (BuildContext context) {
                                          //   return MyApp();
                                          // }));
                                        }).catchError((e) {
                                          AuthService().errorDialog(
                                            context,
                                            "Something went wrong.",
                                          );
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                    ]),
              )
      ],
    );
  }
}
