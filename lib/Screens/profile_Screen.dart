import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Screens/leaderBoard.dart';
import 'package:timepass/Screens/profileSettings.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Widgets/backAerrowWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  Widget container(double height, double width) {
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
                image: AssetImage(
                  'assets/images/s${Random().nextInt(9) + 1}.jpg',
                ))),
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

  //gridview
  Widget gridview(double height, double width) {
    return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: 8,
        padding: EdgeInsets.only(
          left: width * 0.02,
          right: width * 0.02,
        ),
        itemBuilder: (BuildContext context, int i) {
          return container(height, width);
        },
        crossAxisSpacing: width * 0.02,
        mainAxisSpacing: height * 0.015,
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isOdd ? 1 : 1.4);
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

  //CenterBar
  Widget centerbar(double height, double width) {
    return Container(
      height: height * 0.072,
      width: width,
      padding: EdgeInsets.symmetric(
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
          Icon(
            Icons.category,
            size: 31,
          ),
          Icon(
            Icons.play_circle_fill_outlined,
            size: 31,
          ),
          Icon(
            EvaIcons.bookmark,
            size: 31,
          )
        ],
      ),
    );
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
                      image: AssetImage(
                        image,
                      ),
                      fit: BoxFit.fill),
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
      child: Column(
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
                    "assets/images/story1.png",
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
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kiran Tej",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      "vijayawada,AP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ProfileSettingsScreen();
                                    }));
                                  },
                                  icon: Icon(
                                    EvaIcons.settings2Outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(
                              right: width * 0.07,
                              top: height * 0.015,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: height * 0.05,
                                  width: width * 0.28,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(38, 203, 255, 0.86),
                                        Color.fromRGBO(38, 203, 255, 0.5),
                                        Color.fromRGBO(38, 203, 255, 0.48),
                                      ])),
                                  child: Text("Connect",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return LeaderBoard();
                                    }));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: width * 0.04),
                                    alignment: Alignment.center,
                                    height: height * 0.05,
                                    width: width * 0.28,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(200, 16, 46, 0.63),
                                          Color.fromRGBO(200, 16, 46, 0.76),
                                          Color.fromRGBO(200, 16, 46, 0.47),
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
                  calculationsWidget(height, width, "50", "Connections"),
                  calculationsWidget(height, width, "5K", "Total likes"),
                ],
              ),
            ),
            centerbar(height, width),
          ]),
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
