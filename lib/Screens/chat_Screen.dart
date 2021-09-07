import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timepass/Screens/CreateGroup.dart';
import 'package:timepass/Screens/message_screen.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Widgets/backAerrowWidget.dart';

enum SelectTab { Chat, Groups }

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  SelectTab selectTab = SelectTab.Chat;

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

  Widget chatUsers(double height, double width) {
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
          child: chatSections(
              height,
              width,
              "Harsh",
              "Hello karthik..... how are you",
              "assets/images/Ellipse 7.png",
              "7:44 am",
              true,
              false),
        ),
        chatSections(height, width, "Swetha", "Hello karthik..... how are you",
            "assets/images/Ellipse 8.png", "7:44 am", false, false),
        chatSections(height, width, "Balu", "Did you finish your work",
            "assets/images/Ellipse 8.png", "7:44 am", false, true),
        chatSections(height, width, "ABC", "Hello friend..... how are you",
            "assets/images/Ellipse 9.png", "7:44 am", false, false),
        chatSections(height, width, "Kiran", "Hello ABC!",
            "assets/images/Ellipse 10.png", "7:44 am", false, true),
        chatSections(height, width, "Arjun", "How are you ?",
            "assets/images/Ellipse 11.png", "7:44 am", false, false),
        chatSections(height, width, "Balu", "Did you finish your work",
            "assets/images/Ellipse 8.png", "7:44 am", false, false),
        chatSections(height, width, "ABC", "Hello friend..... how are you",
            "assets/images/Ellipse 9.png", "7:44 am", false, false),
      ],
    );
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
              "assets/images/Ellipse 7.png", "7:44 am", true, false),
        ),
        chatSections(height, width, "Kylo apps", "Hello karthik",
            "assets/images/Ellipse 8.png", "7:44 am", false, false),
        chatSections(
            height,
            width,
            "Groups of group",
            "Did you finish your work",
            "assets/images/Ellipse 8.png",
            "7:44 am",
            false,
            false),
        chatSections(
            height,
            width,
            "ABC group",
            "Hello friend..... how are you",
            "assets/images/Ellipse 9.png",
            "7:44 am",
            false,
            false),
      ],
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
          Container(
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
              cursorColor: Colors.black,
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
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(48, 48, 48, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                          color:
                                              Color.fromRGBO(159, 159, 159, 1),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        )
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
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
          ),
        ],
      ),
    );
  }
}
