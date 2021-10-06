import 'package:card_swiper/card_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<String> _images = [
    "Assets/Images/s9.jpg",
    "Assets/Images/s2.jpg",
    "Assets/Images/s4.jpg",
    "Assets/Images/s5.jpg",
    "Assets/Images/s6.jpg",
    "Assets/Images/s7.jpg",
    "Assets/Images/s8.jpg",
    "Assets/Images/s4.jpg",
    "Assets/Images/s5.jpg",
    "Assets/Images/s6.jpg",
    "Assets/Images/s7.jpg",
    "Assets/Images/s8.jpg",
  ];

  Widget divider(double height, double width) {
    return Divider(
      indent: width * 0.02,
      endIndent: width * 0.02,
      color: Colors.black26,
    );
  }

  Widget leaderitems(double height, double width, String leading, String image,
      String title, String likes) {
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.02, right: width * 0.02, bottom: height * 0.008),
      height: height * 0.06,
      width: double.infinity,
      child: Row(children: [
        Text(
          leading,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Container(
                  height: height * 0.088,
                  width: width * 0.088,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Row(children: [
            Text(likes,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            Icon(
              EvaIcons.heart,
              color: Color.fromRGBO(
                38,
                203,
                255,
                1,
              ),
            )
          ]),
        ),
      ]),
    );
  }

  Widget participate(double height, double width) {
    return Container(
        height: height * 0.35,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          scrollDirection: Axis.horizontal,
          layout: SwiperLayout.DEFAULT,
          itemCount: _images.length,
          itemHeight: height * 0.3,
          itemWidth: width * 0.7,
          itemBuilder: (context, int i) {
            return Container(
              height: height * 0.25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      _images[i],
                    ),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black54,
                    backgroundImage: AssetImage(
                      "Assets/Images/profileImage2.png",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Photography",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: width * 0.02,
                      right: width * 0.02,
                      top: height * 0.037,
                      bottom: height * 0.035,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "PARTICIPATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          "LeaderBoard",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.025,
              ),
              participate(height, width),
              SizedBox(
                height: height * 0.035,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                ),
                height: height * 0.23,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.088,
                              width: width * 0.088,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "Assets/Images/s9.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.0001,
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.03,
                                width: width * 0.03,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      "Assets/Images/trophy.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(children: [
                          Text("2.6K",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          Icon(
                            EvaIcons.heart,
                            color: Color.fromRGBO(
                              38,
                              203,
                              255,
                              1,
                            ),
                          )
                        ]),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: height * 0.01),
                              height: height * 0.12,
                              width: width * 0.12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    "Assets/Images/profileImage2.png",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.0001,
                              top: 0,
                              bottom: height * 0.09,
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.05,
                                width: width * 0.04,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromRGBO(241, 216, 81, 1),
                                  ),
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      "Assets/Images/trophy.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2.6K",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Icon(
                                EvaIcons.heart,
                                color: Color.fromRGBO(
                                  38,
                                  203,
                                  255,
                                  1,
                                ),
                              )
                            ]),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.088,
                              width: width * 0.088,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "Assets/Images/s5.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.0001,
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.03,
                                width: width * 0.03,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      "Assets/Images/trophy.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(children: [
                          Text("2.6K",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          Icon(
                            EvaIcons.heart,
                            color: Color.fromRGBO(
                              38,
                              203,
                              255,
                              1,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              leaderitems(height, width, "#4", "Assets/Images/s5.jpg",
                  "first name", "2.6K"),
              divider(height, width),
              leaderitems(height, width, "#5", "Assets/Images/s6.jpg",
                  "Second name", "2.6K"),
              divider(height, width),
              leaderitems(height, width, "#6", "Assets/Images/s7.jpg",
                  "third name", "2.6K"),
              divider(height, width),
            ],
          ),
        ),
      ),
    );
  }
}
