import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import 'package:timepass/API/APIservices.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/API/MessageAPI.dart';

import 'package:timepass/Utils/colors.dart';

import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/models/chatUserModel.dart';
import 'package:timepass/models/profileModel.dart';
import '../main.dart';

class MessageScreen extends StatefulWidget {
  final String? roomid;
  final String? receiverUserid;

  MessageScreen({
    this.roomid,
    this.receiverUserid,
  });

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  late IO.Socket socket;
  Widget senderwidgets = Container();
  Widget receiverWidget = Container();

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getSenderWidgetmethod();
    getreceiverWidgetmethod();
    super.didChangeDependencies();
  }

  getSenderWidgetmethod() {
    setState(() {
      senderwidgets = getWidgets(userid!);
    });
  }

  getreceiverWidgetmethod() {
    setState(() {
      senderwidgets = getWidgets(widget.receiverUserid!);
    });
  }

  Widget getWidgets(String id) {
    return cirImage(id, MediaQuery.of(context).size.height);
  }

  // socket initializing.....
  void initSocket() async {
    try {
      socket = IO.io(
          weburl,
          IO.OptionBuilder()
              .setTransports(["websocket"])
              .disableAutoConnect()
              .build());
      socket.connect();
      // socket.onConnecting((data) => print("connecting"));
      socket.onConnect((data) => print("connected"));
      // socket.on("join room", (data) => print("joined"));

      socket.onConnectError((data) => print(data.toString()));

      // socket.onError((data) => print(data.toString()));
      print(socket.connected);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    socket.dispose();

    super.dispose();
  }

  // receiver section (message widget)
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
          // cirImage(widget.receiverUserid!, height),
          receiverWidget,
          Container(
            constraints: BoxConstraints(
              maxWidth: width * 0.6,
            ),
            child: Bubble(
              colors: receiverGradient,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Appbar widget
  Widget appBarTitle(double height, double width) {
    return FutureBuilder(
        future: APIServices().getProfileofChatUsers(widget.receiverUserid!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserSearchModel> searchModel = [];
            jsonDecode(snapshot.data).forEach((element) {
              UserSearchModel userSearchModel =
                  UserSearchModel.fromJson(element);
              searchModel.add(userSearchModel);
            });
            return ListTile(
              leading: CircleAvatar(
                  radius: 19,
                  backgroundImage:
                      CachedNetworkImageProvider(searchModel[0].imageUrl!)),
              title: Text(
                searchModel[0].name!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              // subtitle: Text(
              //   "active 20 min ago",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 10,
              //       fontWeight: FontWeight.w400),
              // ),
            );
          } else {
            return Container();
          }
        });
  }

  // get image from profile api,
  Widget cirImage(String id, double height) {
    return FutureBuilder(
        future: APIServices().getProfileofChatUsers(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserSearchModel> searchModel = [];
            jsonDecode(snapshot.data).forEach((element) {
              UserSearchModel userSearchModel =
                  UserSearchModel.fromJson(element);
              searchModel.add(userSearchModel);
            });
            return Container(
              margin: EdgeInsets.only(top: height * 0.007),
              child: CircleAvatar(
                radius: 15,
                backgroundImage:
                    CachedNetworkImageProvider(searchModel[0].imageUrl!),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  // sender seection(Message widget)
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
              colors: senderGradient,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // cirImage(userid!, height),
          senderwidgets,
        ],
      ),
    );
  }

  // get message list and build a list
  Widget messageList(double height, double width) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: MessageAPI().getMessages(widget.roomid!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = jsonDecode(snapshot.data);
                List<MessageModel> _listOfMessages = [];
                data["Messages"].forEach((element) {
                  MessageModel model = MessageModel.fromJson(element);
                  _listOfMessages.add(model);
                });

                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _listOfMessages.length,
                    itemBuilder: (BuildContext context, int i) {
                      return _listOfMessages[i].senderId == userid
                          ? senderSection(
                              height, width, _listOfMessages[i].message!)
                          : receiverSection(
                              height, width, _listOfMessages[i].message!);
                    });
              } else {
                return Center(child: circularProgressIndicator());
              }
            }),
        // hardcoded widget, UI implementation
        // child: ListView(
        //   physics: BouncingScrollPhysics(),
        //   children: [
        //     senderSection(height, width, "Hello How are you?"),
        //     receiverSection(height, width, "Hello"),
        //     receiverSection(height, width, "I am fine!"),
        //     senderSection(height, width, "Nice to meet you"),
        //     senderSection(height, width,
        //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        //     receiverSection(height, width,
        //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        //     senderSection(height, width, "Hello How are you?"),
        //     receiverSection(height, width, "Hello"),
        //     receiverSection(height, width, "I am fine!"),
        //     senderSection(height, width, "Nice to meet you"),
        //     senderSection(height, width,
        //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        //     receiverSection(height, width,
        //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        //   ],
        // ),
      ),
    );
  }

  // send  message textfield
  Widget sendMessageTextField(double height, double width) {
    return Align(
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
              child: Row(
            children: [
              Expanded(
                child: TextField(
                    maxLines: 7,
                    minLines: 1,
                    controller: messageController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write a message",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(124, 124, 124, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
              IconButton(
                onPressed: () {
                  MessageAPI().getMessagesupdate(widget.roomid!);
                },
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.black,
                ),
              ),
            ],
          )),
        ),
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
              EvaIcons.moreHorizontal,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          messageList(height, width),
          sendMessageTextField(height, width),
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
