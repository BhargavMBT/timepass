import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:timepass/API/BasicAPI.dart';

import 'package:timepass/Screens/profile_Screen.dart';
import 'package:timepass/Utils/colors.dart';

import 'package:http/http.dart' as http;
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';
import 'package:timepass/models/profileModel.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final String? name;
  final String? id;
  final String? imageurl;
  final String? connectionsLength;
  final List<dynamic>? connections;
  OtherUserProfileScreen(
      {this.name,
      this.id,
      this.imageurl,
      this.connections,
      this.connectionsLength});

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  void initState() {
    super.initState();
  }
  //Leading icon

  //grid items
  Widget gridItems(String path) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(path),
        ),
      ),
    );
  }

  Future getProfile() async {
    try {
      var url = Uri.parse('$weburl/users/search?_id=${widget.id}');
      var response;
      if (xAccessToken != null) {
        response = await http.get(
          url,
        );
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    }
  }

  Future getUserPost() async {
    try {
      var url = Uri.parse('$weburl/posts/post/${widget.id}');
      var response;
      if (xAccessToken != null) {
        response = await http.get(url, headers: {
          'x-access-token': xAccessToken!,
        });
        if (response.statusCode == 200) {
          return response.body;
          // return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    }
  }

  Widget imageContainer(double height, double width, String imageUrl) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.009,
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600]!,
                blurRadius: 0.07,
                spreadRadius: 0.07,
              )
            ],
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imageUrl),
            )),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
            height: height * 0.05,
            margin: EdgeInsets.only(
              right: width * 0.03,
              bottom: 0,
            ),
            alignment: Alignment.centerRight,
            child: Container(
              height: height * 0.06,
              width: width * 0.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(
                  0.4,
                ),
              ),
              child: Icon(
                EvaIcons.share,
                size: 12,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            )),
      ),
    ]);
  }

  PostCategory postCategory = PostCategory.Image;

  Widget videoContainer(double height, double width, String url) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.009,
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600]!,
              blurRadius: 0.07,
              spreadRadius: 0.07,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PostVideoIntializeWidget(
            url: url,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Container(
            height: height * 0.05,
            margin: EdgeInsets.only(
              right: width * 0.03,
              bottom: 0,
            ),
            alignment: Alignment.centerRight,
            child: Container(
              height: height * 0.06,
              width: width * 0.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(
                  0.4,
                ),
              ),
              child: Icon(
                EvaIcons.share,
                size: 12,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            )),
      ),
      Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PostVideoPlayer(
                url: url,
              );
            }));
          },
          child: Icon(
            EvaIcons.playCircleOutline,
            size: height * 0.035,
            color: Colors.grey[300],
          ),
        ),
      ),
    ]);
  }

  Future createConversation() async {
    try {
      var url = Uri.parse('$weburl/conversations/conversation');
      var body = jsonEncode({
        "roomName": "Hello !",
        "users": [userid, widget.id],
      });

      if (xAccessToken != null) {
        var response = await http.post(
          url,
          body: body,
          headers: {
            'x-access-token': xAccessToken!,
            "Content-Type": "application/json"
          },
        );
        if (response.statusCode == 200) {
          return response.body;
          // return response.body;
        } else if (response.statusCode == 201) {
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      // throw Exception("Oops! Something went wrong");
    }
  }

  //gridview
  Widget gridview(double height, double width) {
    return FutureBuilder(
        future: getUserPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var postDataList = jsonDecode(snapshot.data!);
            List<ProfileModel> _totalList = [];
            List<ProfileModel> _imagelist = [];
            List<ProfileModel> _videolist = [];
            postDataList.forEach((element) {
              ProfileModel model = ProfileModel.fromJson(element);
              _totalList.add(model);
              if (model.type == "Image") {
                _imagelist.add(model);
              } else if (model.type == "Video") {
                _videolist.add(model);
              }
            });
            return _totalList.isEmpty
                ? Container(
                    height: height * 0.25,
                    alignment: Alignment.center,
                    child: Text("Posts are not generated."))
                : postCategory == PostCategory.Image
                    ? _imagelist.isEmpty
                        ? Container(
                            height: height * 0.25,
                            alignment: Alignment.center,
                            child: Text("Image posts are not generated."))
                        : StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: _imagelist.length,
                            padding: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.02,
                            ),
                            itemBuilder: (BuildContext context, int i) {
                              return imageContainer(
                                height,
                                width,
                                _imagelist[i].postUrl!,
                              );
                            },
                            crossAxisSpacing: width * 0.02,
                            mainAxisSpacing: height * 0.015,
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.count(
                                  1, index.isOdd ? 1 : 1.4);
                            })
                    : postCategory == PostCategory.Video
                        ? _videolist.isEmpty
                            ? Container(
                                height: height * 0.25,
                                alignment: Alignment.center,
                                child: Text("Video posts are not generated."))
                            : StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                itemCount: _videolist.length,
                                padding: EdgeInsets.only(
                                  left: width * 0.02,
                                  right: width * 0.02,
                                ),
                                itemBuilder: (BuildContext context, int i) {
                                  return videoContainer(
                                    height,
                                    width,
                                    _videolist[i].postUrl!,
                                  );
                                },
                                crossAxisSpacing: width * 0.02,
                                mainAxisSpacing: height * 0.015,
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1, index.isOdd ? 1 : 1.4);
                                })
                        : Container();
          } else if (snapshot.hasError) {
            return Container(
              height: height * 0.25,
              alignment: Alignment.center,
              child: Text("Something went wrong! Try again later."),
            );
          } else {
            return Container(
              height: height * 0.6,
              child: Center(child: circularProgressIndicator()),
            );
          }
        });
  }

  Widget calculationsWidget(
      double height, double width, String title, String subtitle) {
    return Container(
      height: height * 0.1,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.011, bottom: height * 0.01),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(subtitle,
              style: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(255, 255, 255, 0.74),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              )),
        ],
      ),
    );
  }

  Widget centerbar(double height, double width) {
    return Container(
      height: height * 0.072,
      width: width,
      padding: postCategory == PostCategory.Image
          ? EdgeInsets.only(right: width * 0.06)
          : postCategory == PostCategory.Bookmark
              ? EdgeInsets.only(left: width * 0.06)
              : EdgeInsets.symmetric(
                  horizontal: width * 0.06,
                ),
      margin: EdgeInsets.only(
        top: height * 0.005,
        left: width * 0.08,
        right: width * 0.08,
        bottom: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(147, 144, 144, 0.25),
            offset: Offset(0, 7),
            blurRadius: 10,
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          postCategory == PostCategory.Image
              ? selectedCatagory(
                  height,
                  width,
                  Icon(
                    Icons.category,
                    size: 31,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      postCategory = PostCategory.Image;
                    });
                  },
                  child: Icon(
                    Icons.category,
                    size: 31,
                  ),
                ),
          postCategory == PostCategory.Video
              ? selectedCatagory(
                  height,
                  width,
                  Icon(
                    Icons.play_circle_fill_outlined,
                    size: 31,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      postCategory = PostCategory.Video;
                    });
                  },
                  child: Icon(
                    Icons.play_circle_fill_outlined,
                    size: 31,
                  ),
                ),
          postCategory == PostCategory.Bookmark
              ? selectedCatagory(
                  height,
                  width,
                  Icon(
                    EvaIcons.bookmark,
                    size: 31,
                  ))
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      postCategory = PostCategory.Bookmark;
                    });
                  },
                  child: Icon(
                    EvaIcons.bookmark,
                    size: 31,
                  ),
                )
        ],
      ),
    );
  }

  Widget selectedCatagory(double height, double width, Widget icon) {
    return Container(
        width: width * 0.25,
        height: height * 0.072,
        decoration: BoxDecoration(
          gradient: profileCategoryGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(147, 144, 144, 0.25),
              offset: Offset(0, 7),
              blurRadius: 10,
              spreadRadius: 0,
            )
          ],
        ),
        child: icon);
  }

  Widget storyContainer(
    double height,
    double width,
    String image,
  ) {
    return Container(
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(3.2),
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: height * 0.105,
                width: width * 0.22,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(38, 203, 255, 1),
              Color.fromRGBO(38, 203, 255, 1),
              Color.fromRGBO(105, 128, 253, 1),
              Color.fromRGBO(105, 128, 253, 1),
            ]),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }

  bool isloadingConnect = false;

  Future connectUser() async {
    try {
      setState(() {
        isloadingConnect = true;
      });
      var url = Uri.parse('$weburl/profile/connection/add/${widget.id}');

      if (xAccessToken != null) {
        var response = await http.patch(url, headers: {
          'x-access-token': xAccessToken!,
        });
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    } finally {
      setState(() {
        isloadingConnect = false;
      });
    }
  }

  Future removeConnectUser() async {
    try {
      setState(() {
        isloadingConnect = true;
      });
      var url = Uri.parse('$weburl/profile/connection/remove/${widget.id}');

      if (xAccessToken != null) {
        var response = await http.patch(url, headers: {
          'x-access-token': xAccessToken!,
        });
        if (response.statusCode == 200) {
          return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      throw Exception("Oops! Something went wrong");
    } finally {
      setState(() {
        isloadingConnect = false;
      });
    }
  }

  //profile Header
  Widget profileHeader(double height, double width) {
    return Container(
      height: height * 0.405,
      width: width,
      decoration: BoxDecoration(
          color: Color.fromRGBO(40, 40, 40, 1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          )),
      child: FutureBuilder(
          future: getProfile(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<UserSearchModel> searchModel = [];
              jsonDecode(snapshot.data).forEach((element) {
                UserSearchModel userSearchModel =
                    UserSearchModel.fromJson(element);
                searchModel.add(userSearchModel);
              });
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.015),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.045,
                        top: height * 0.025,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          storyContainer(
                            height,
                            width,
                            searchModel[0].imageUrl!,
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Text(
                                    searchModel[0].name!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: width * 0.07,
                                      top: height * 0.02,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: searchModel[0]
                                                  .connections!
                                                  .any((element) =>
                                                      element["userId"] ==
                                                      userid)
                                              ? removeConnectUser
                                              : connectUser,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: height * 0.05,
                                            width: width * 0.28,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      38, 203, 255, 0.86),
                                                  Color.fromRGBO(
                                                      38, 203, 255, 0.5),
                                                  Color.fromRGBO(
                                                      38, 203, 255, 0.48),
                                                ])),
                                            child: isloadingConnect
                                                ? Container(
                                                    height: height * 0.025,
                                                    width: width * 0.03,
                                                    child:
                                                        circularProgressIndicator(
                                                            whitecolors: true))
                                                : searchModel[0]
                                                        .connections!
                                                        .any((element) =>
                                                            element["userId"] ==
                                                            userid)
                                                    ? Text("Connected",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ))
                                                    : Text("Connect",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: createConversation,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: width * 0.04),
                                            alignment: Alignment.center,
                                            height: height * 0.05,
                                            width: width * 0.28,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      200, 16, 46, 0.63),
                                                  Color.fromRGBO(
                                                      200, 16, 46, 0.76),
                                                  Color.fromRGBO(
                                                      200, 16, 46, 0.47),
                                                ])),
                                            child: Text("Message",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.15,
                        right: width * 0.15,
                        top: height * 0.028,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          calculationsWidget(height, width, "100", "Stories"),
                          calculationsWidget(
                              height,
                              width,
                              searchModel[0].connections!.length.toString(),
                              "Connections"),
                          calculationsWidget(
                              height, width, "5K", "Total likes"),
                        ],
                      ),
                    ),
                    centerbar(height, width),
                  ]);
            } else if (snapshot.hasError) {
              return Text("Something went wrong");
            } else {
              return Center(
                child: circularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        color: Colors.white,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            profileHeader(height, width),
            SizedBox(
              height: height * 0.015,
            ),
            gridview(height, width),
          ],
        ),
      ),
    );
  }
}
