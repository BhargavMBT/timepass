import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timepass/API/APIservices.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Screens/CreateGroup.dart';
import 'package:timepass/Screens/message_screen.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Widgets/animationWidget.dart';
import 'package:timepass/Widgets/backAerrowWidget.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/models/chatUserModel.dart';
import 'package:timepass/models/profileModel.dart';

enum SelectTab { Chat, Groups }
enum ScreenType { Search, Chat }

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();
  SelectTab selectTab = SelectTab.Chat;
  ScreenType type = ScreenType.Chat;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    getConversations();
    super.initState();
  }

  getConversations() async {
    try {
      var url = Uri.parse('$weburl/conversations/my');
      var response;
      if (xAccessToken != null) {
        response = await http.get(
          url,
          headers: {
            'x-access-token': xAccessToken!,
          },
        );

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
      print(e.toString());
      throw Exception("Oops! Something went wrong");
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget userchatSections(
      String uid,
      double height,
      double width,
      String title,
      String subtitle,
      String imagePath,
      String time,
      bool notify,
      bool status) {
    return FutureBuilder(
        future: APIServices().getProfileofChatUsers(uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserSearchModel> searchModel = [];
            jsonDecode(snapshot.data).forEach((element) {
              UserSearchModel userSearchModel =
                  UserSearchModel.fromJson(element);
              searchModel.add(userSearchModel);
            });
            return Container(
              child: ListTile(
                title: Text(
                  searchModel[0].name!,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(
                      255,
                      255,
                      255,
                      0.59,
                    ),
                  ),
                ),
                leading: Stack(children: [
                  CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(searchModel[0].imageUrl!),
                  ),
                  status
                      ? CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.green,
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ]),
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
                            255,
                            255,
                            255,
                            1,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget chatSections(
      double height,
      double width,
      String title,
      String subtitle,
      String imagePath,
      String time,
      bool notify,
      bool status) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(
              255,
              255,
              255,
              0.59,
            ),
          ),
        ),
        leading: Stack(children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          status
              ? CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.green,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ]),
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
                    255,
                    255,
                    255,
                    1,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  List<UserSearchModel>? _usersearchModel = [];
  Future searchUsers(String query) async {
    try {
      var url = Uri.parse('$weburl/users/search?name=$query');
      var response;
      if (xAccessToken != null) {
        response = await http.get(
          url,
        );

        if (response.statusCode == 200) {
          List<UserSearchModel> searchModel = [];
          jsonDecode(response.body).forEach((element) {
            UserSearchModel userSearchModel = UserSearchModel.fromJson(element);
            searchModel.add(userSearchModel);
          });
          setState(() {
            _usersearchModel = searchModel;
          });
          // return response.body;
        } else {
          throw Exception("Oops! Something went wrong");
        }
      } else {
        throw Exception("Oops! Something went wrong");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Oops! Something went wrong");
    }
  }

  Widget chatUsers(double height, double width) {
    return FutureBuilder(
        future: getConversations(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ChatUserModel> _listUsers = [];
            var data = jsonDecode(snapshot.data);

            data.forEach((element) {
              ChatUserModel model = ChatUserModel.fromJson(element);

              _listUsers.add(model);
            });
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _listUsers.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () {
                      navagtionRoute(
                          context,
                          MessageScreen(
                            roomid: _listUsers[i].roomid,
                            receiverUserid: _listUsers[i].users!.firstWhere(
                                (element) =>
                                    element["user"].toString() !=
                                    userid)["user"],
                          ));
                    },
                    child: userchatSections(
                        _listUsers[i].users!.firstWhere((element) =>
                            element["user"].toString() != userid)["user"],
                        height,
                        width,
                        "Harsh",
                        "Hello karthik..... how are you",
                        "Assets/Images/Ellipse 7.png",
                        "7:44 am",
                        true,
                        false),
                  );
                });
            // return ListView(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         // Navigator.push(
            //         //   context,
            //         //   MaterialPageRoute(
            //         //     builder: (BuildContext context) {
            //         //       return MessageScreen();
            //         //     },
            //         //   ),
            //         // );
            //         navagtionRoute(context, MessageScreen());
            //       },
            //       child: chatSections(
            //           height,
            //           width,
            //           "Harsh",
            //           "Hello karthik..... how are you",
            //           "Assets/Images/Ellipse 7.png",
            //           "7:44 am",
            //           true,
            //           false),
            //     ),
            //     chatSections(
            //         height,
            //         width,
            //         "Swetha",
            //         "Hello karthik..... how are you",
            //         "Assets/Images/Ellipse 8.png",
            //         "7:44 am",
            //         false,
            //         false),
            //     chatSections(height, width, "Balu", "Did you finish your work",
            //         "Assets/Images/Ellipse 8.png", "7:44 am", false, true),
            //     chatSections(height, width, "ABC", "Hello friend..... how are you",
            //         "Assets/Images/Ellipse 9.png", "7:44 am", false, false),
            //     chatSections(height, width, "Kiran", "Hello ABC!",
            //         "Assets/Images/Ellipse 10.png", "7:44 am", false, true),
            //     chatSections(height, width, "Arjun", "How are you ?",
            //         "Assets/Images/Ellipse 11.png", "7:44 am", false, false),
            //     chatSections(height, width, "Balu", "Did you finish your work",
            //         "Assets/Images/Ellipse 8.png", "7:44 am", false, false),
            //     chatSections(height, width, "ABC", "Hello friend..... how are you",
            //         "Assets/Images/Ellipse 9.png", "7:44 am", false, false),
            //   ],
            // );
          } else {
            return Container(
              height: height*0.5,
              child: Center(
                child: circularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget groupChats(double height, double width) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MessageScreen();
                },
              ),
            );
          },
          child: chatSections(height, width, "Funcky guys", "how are you? Guys",
              "Assets/Images/Ellipse 7.png", "7:44 am", true, false),
        ),
        chatSections(
          height,
          width,
          "Kylo apps",
          "Hello karthik",
          "Assets/Images/Ellipse 9.png",
          "7:44 am",
          false,
          false,
        ),
        chatSections(
            height,
            width,
            "Groups of group",
            "Did you finish your work",
            "Assets/Images/Ellipse 8.png",
            "7:44 am",
            false,
            false),
        chatSections(
            height,
            width,
            "ABC group",
            "Hello friend..... how are you",
            "Assets/Images/Ellipse 9.png",
            "7:44 am",
            false,
            false),
      ],
    );
  }

  Widget searchSection(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.08,
        vertical: height * 0.008,
      ),
      height: height * 0.065,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.05,
          color: Color.fromRGBO(112, 112, 112, 0.25),
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            spreadRadius: 0,
            offset: Offset(7, 17),
            color: Color.fromRGBO(112, 112, 112, 0.25),
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: searchController,
        focusNode: focusNode,
        cursorColor: Colors.black,
        onFieldSubmitted: (String? value) {
          if (value != null) {
            searchUsers(value);
          }
        },
        onChanged: (String? value) {
          if (value!.trim().isNotEmpty) {
            if (type == ScreenType.Chat) {
              setState(() {
                type = ScreenType.Search;
              });
            }
          } else {
            if (type == ScreenType.Search) {
              setState(() {
                type = ScreenType.Chat;
              });
            }
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            EvaIcons.searchOutline,
            color: Colors.black,
          ),
          hintText: "Search for chats",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(150, 150, 150, 1),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget sectionOfChatting(double height, double width) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(48, 48, 48, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              alignment: Alignment.center,
              height: height * 0.045,
              width: width * 0.550,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 2),
                      blurRadius: 15,
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.225, vertical: height * 0.02),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectTab = SelectTab.Chat;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: height * 0.045,
                        width: width * 0.275,
                        child: Text(
                          "Chats",
                          style: TextStyle(
                            color: selectTab == SelectTab.Chat
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        decoration: selectTab == SelectTab.Chat
                            ? BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(38, 203, 255, 1),
                                  Color.fromRGBO(105, 128, 253, 0.5),
                                ]),
                                color: Color.fromRGBO(159, 159, 159, 1),
                                borderRadius: BorderRadius.circular(25),
                              )
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectTab = SelectTab.Groups;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.045,
                      width: width * 0.275,
                      decoration: selectTab == SelectTab.Groups
                          ? BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(38, 203, 255, 1),
                                Color.fromRGBO(105, 128, 253, 0.5),
                              ]),
                              color: Color.fromRGBO(159, 159, 159, 1),
                              borderRadius: BorderRadius.circular(25),
                            )
                          : BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                      child: Text(
                        "Groups",
                        style: TextStyle(
                          color: selectTab == SelectTab.Groups
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            selectTab == SelectTab.Chat
                ? chatUsers(height, width)
                : groupChats(height, width),
          ]),
        ),
      ),
    );
  }

  Widget searchResultWidget(double height, double width) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
            itemCount: _usersearchModel!.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                leading: CircleAvatar(
                  radius: height * 0.02,
                  backgroundImage: CachedNetworkImageProvider(
                      _usersearchModel![i].imageUrl!),
                ),
                title: Text(_usersearchModel![i].name!),
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          selectTab == SelectTab.Chat ? "Messages" : "Group",
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          )
        ],
      ),
      floatingActionButton: SelectTab.Chat == selectTab
          ? Container()
          : Container(
              height: height * 0.06,
              margin: EdgeInsets.only(bottom: height * 0.11),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CreateGroup();
                  }));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
      body: Column(
        children: [
          searchSection(height, width),
          SizedBox(
            height: height * 0.02,
          ),
          type == ScreenType.Chat
              ? sectionOfChatting(height, width)
              : searchResultWidget(height, width)
          // KeyboardVisibilityBuilder(builder: (context, child, visible) {
          //   if (!visible) {
          //     return sectionOfChatting(height, width);
          //   } else {
          //     return Container(
          //       color: Theme.of(context).primaryColor,
          //     );
          //   }
          // }),
        ],
      ),
    );
  }
}

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget? child;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  const KeyboardVisibilityBuilder({
    Key? key,
    this.child,
    required this.builder,
  }) : super(key: key);

  @override
  _KeyboardVisibilityBuilderState createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.child,
        _isKeyboardVisible,
      );
}
