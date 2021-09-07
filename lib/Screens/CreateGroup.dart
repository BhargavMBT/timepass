import 'package:flutter/material.dart';
import 'package:timepass/Screens/message_screen.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  Widget contactItems(
      double height, double width, String title, String image, bool select) {
    return Container(
      child: Column(children: [
        Container(
          child: Stack(
            children: [
              CircleAvatar(
                radius: height * 0.038,
                backgroundImage: AssetImage(image),
              ),
              select
                  ? Positioned(
                      top: height * 0.045,
                      right: width * 0.001,
                      child: CircleAvatar(
                        radius: height * 0.014,
                        backgroundColor: Color.fromRGBO(97, 254, 188, 1),
                        child: Icon(
                          Icons.check_circle_outline,
                          size: height * 0.022,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.011),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: backAerrowButton(height, width),
        ),
        centerTitle: true,
        title: Text(
          "Create Group",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.03),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                      height: height * 0.21,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(196, 196, 196, 1),
                      )),
                  Positioned(
                    top: height * 0.145,
                    left: width * 0.185,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: height * 0.015,
                      child: Icon(
                        Icons.add,
                        size: height * 0.02,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.55,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Color.fromRGBO(235, 235, 235, 1),
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: width * 0.02),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter group name",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: height * 0.05),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 19, 19, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(43),
                      topRight: Radius.circular(43),
                    )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.09,
                          left: width * 0.08,
                        ),
                        child: Text(
                          "Contacts",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.04,
                          left: width * 0.08,
                          right: width * 0.08,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            contactItems(height, width, "Kiran",
                                "assets/images/Ellipse 9.png", false),
                            contactItems(height, width, "Sagar",
                                "assets/images/Ellipse 8.png", false),
                            contactItems(height, width, "K k",
                                "assets/images/Ellipse 10.png", true),
                            contactItems(height, width, "ABC",
                                "assets/images/Ellipse 11.png", true),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.04,
                          left: width * 0.08,
                          right: width * 0.08,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            contactItems(height, width, "K k",
                                "assets/images/Ellipse 10.png", false),
                            contactItems(height, width, "ABC",
                                "assets/images/Ellipse 11.png", false),
                            contactItems(height, width, "Kiran",
                                "assets/images/Ellipse 9.png", true),
                            contactItems(height, width, "Sagar",
                                "assets/images/Ellipse 8.png", false),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: height * 0.045,
                          ),
                          height: height * 0.06,
                          width: width * 0.52,
                          child: Text("Create group",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Color.fromRGBO(255, 105, 21, 1)),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
