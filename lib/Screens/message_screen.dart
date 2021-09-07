import 'package:bubble/bubble.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Widget receiverSection(
    double height,
    double width,
    String title,
  ) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.02, bottom: height * 0.015),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.007),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(
                "assets/images/Ellipse 8.png",
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: width * 0.6,
            ),
            child: Bubble(
              colors: [
//

                Color.fromRGBO(226, 134, 14, 1),
                Color.fromRGBO(255, 179, 79, 1),
                Color.fromRGBO(255, 179, 79, 1),
              ],
              margin: BubbleEdges.only(top: 10),
              stick: true,
              radius: Radius.elliptical(13, 10),
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(246, 245, 245, 1),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarTitle(double height, double width) {
    return ListTile(
      leading: CircleAvatar(
        radius: 19,
        backgroundImage: AssetImage(
          "assets/images/Ellipse 7.png",
        ),
      ),
      title: Text(
        "Harsh",
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        "active 20 min ago",
        style: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget senderSection(
    double height,
    double width,
    String title,
  ) {
    return Container(
      margin: EdgeInsets.only(right: width * 0.02, bottom: height * 0.015),
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: width * 0.6,
            ),
            child: Bubble(
              colors: [
                Color.fromRGBO(38, 203, 255, 1),
                Color.fromRGBO(105, 128, 253, 1),
              ],
              margin: BubbleEdges.only(top: 10),
              stick: true,
              nip: BubbleNip.rightTop,
              radius: Radius.elliptical(13, 10),
              color: Color.fromRGBO(225, 255, 199, 1.0),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.007),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(
                "assets/images/Ellipse 7.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        bottom: PreferredSize(
          child: Divider(
            height: height * 0.015,
            color: Colors.black54,
          ),
          preferredSize: Size(
            width,
            height * 0.015,
          ),
        ),

        // leadingWidth: width * 0.1,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: backAerrowButton(height, width)),
        title: appBarTitle(height, width),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              EvaIcons.moreHorizotnal,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  senderSection(height, width, "Hello How are you?"),
                  receiverSection(height, width, "Hello"),
                  receiverSection(height, width, "I am fine!"),
                  senderSection(height, width, "Nice to meet you"),
                  senderSection(height, width,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                  receiverSection(height, width,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                  senderSection(height, width, "Hello How are you?"),
                  receiverSection(height, width, "Hello"),
                  receiverSection(height, width, "I am fine!"),
                  senderSection(height, width, "Nice to meet you"),
                  senderSection(height, width,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                  receiverSection(height, width,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Container(
                constraints: BoxConstraints(minHeight: height * 0.07),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: width * 0.04),
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
                    horizontal: width * 0.04, vertical: height * 0.01),
                child: Container(
                  child: TextField(
                      maxLines: 7,
                      minLines: 1,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a message",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(124, 124, 124, 1),
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.error_outlined,
                                color: Colors.red[300]!,
                              ),
                            ),
                            IconButton(
                              onPressed: null,
                              icon: Icon(
                                EvaIcons.plusCircleOutline,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget backAerrowButton(
  double height,
  double width,
) {
  return Container(
    margin: EdgeInsets.only(
      top: height * 0.02,
      left: width * 0.025,
      bottom: height * 0.02,
      right: 0,
    ),
    alignment: Alignment.center,
    padding: EdgeInsets.only(
      left: width * 0.01,
    ),
    height: height * 0.05,
    width: width * 0.05,
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(
            0,
            0,
            0,
            0.25,
          ),
          blurRadius: 14,
          spreadRadius: 0,
          offset: Offset(6, 6),
        )
      ],
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.arrow_back_ios,
      size: 13,
      color: Colors.black,
    ),
  );
}
