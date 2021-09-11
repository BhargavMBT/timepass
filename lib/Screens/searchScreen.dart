import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:timepass/Screens/profile_Screen.dart';
import 'package:timepass/Widgets/moreWidget.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/models/memesModel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> imageItems = [
    "assets/images/s9.jpg",
    "assets/images/s2.jpg",
    "assets/images/s4.jpg",
    "assets/images/s5.jpg",
    "assets/images/s6.jpg",
    "assets/images/s7.jpg",
    "assets/images/s8.jpg",
    "assets/images/s4.jpg",
    "assets/images/s5.jpg",
    "assets/images/s6.jpg",
    "assets/images/s7.jpg",
    "assets/images/s8.jpg",
  ];

  Future getMemePosts() async {
    try {
      var url = Uri.parse("https://www.reddit.com/r/memes.json");
      var data = await http.get(url);
      // var jsonData = json.decode(data.body);

      // List<Posts> posts=[]
      // for(var u in jsonData['data']['children']){
      //     if(post.url.contains('.jpg'){
      //         Posts post = Posts(url: u['data']['url']);
      //         posts.add(post);
      //     }
      // }
      // print(data.body);
      return data.body;
    } catch (e) {
      print(e.toString());

      // throw Exception("Soemthing went wrong");
    }
  }

  AppBar appbarOfHOmepage(double height, double width) {
    return AppBar(
      leading:
          // Builder(
          //   builder: (BuildContext context) {
          //     return
          GestureDetector(
        onTap: () {
          // Scaffold.of(context).openDrawer();
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return MoreWidget();
          }));
        },
        child: Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.01,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.01,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            height: MediaQuery.of(context).size.height * 0.01,
            width: MediaQuery.of(context).size.width * 0.01,
            child: Image(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.02,
              image: AssetImage(
                "assets/images/leadingIcon.png",
              ),
            )),
      ),
      //     ;
      //   },
      // ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ProfileScreen();
            }));
          },
          child: Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.07,
              child: Image(
                alignment: Alignment.center,
                image: AssetImage(
                  "assets/images/profileImage.png",
                ),
              )),
        ),
      ],
      elevation: 0,
      title: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.011,
        ),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.15,
        child: Image.asset(
          "assets/images/socioClub2x.png",
          fit: BoxFit.fill,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget postSwiperWidget(double height, double width) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: FutureBuilder(
              future: getMemePosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var jsonData = jsonDecode(snapshot.data);
                  List<MemeModel> _posts = [];
                  for (var u in jsonData['data']['children']) {
                    if (u["data"]["url"].contains('.jpg') ||
                        u["data"]["url"].contains('.png') ||
                        u["data"]["url"].contains('.gif')) {
                      MemeModel post = MemeModel.fromJson(u['data']['url']);
                      _posts.add(post);
                    }
                  }
                  return Swiper(
                    outer: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: height * 0.7,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _posts[index].imageurl!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: width * 0.02,
                                top: height * 0.01,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "assets/images/story1.png",
                                  ),
                                ),
                                title: Text(
                                  "first lastname",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  height: height * 0.08,
                                  margin: EdgeInsets.only(
                                    right: width * 0.03,
                                    bottom: 0,
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: height * 0.09,
                                    width: width * 0.09,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(
                                        0.4,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.share,
                                      size: 15,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: imageItems.length,
                    itemWidth: width * 0.79,
                    duration: 100,
                    viewportFraction: 0.2,
                    itemHeight: height * 0.52,
                    layout: SwiperLayout.STACK,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                } else {
                  return Center(
                    child: circularProgressIndicator(),
                  );
                }
              })),
    );
  }

  Widget items(double height, double width, String title, List<Color> color,
      Color titleColor) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.015),
      height: height * 0.05,
      width: width * 0.27,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: color)),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget optionsWidget(double height, double width) {
    return Container(
      height: height * 0.12,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            items(
              height,
              width,
              "Memes",
              [
                Color.fromRGBO(116, 116, 116, 1),
                Color.fromRGBO(55, 55, 55, 1),
              ],
              Colors.white,
            ),
            items(
              height,
              width,
              "Contests",
              [
                Color.fromRGBO(221, 221, 221, 1),
                Color.fromRGBO(221, 221, 221, 1),
              ],
              Color.fromRGBO(154, 154, 154, 1),
            ),
            items(
              height,
              width,
              "Games",
              [
                Color.fromRGBO(221, 221, 221, 1),
                Color.fromRGBO(221, 221, 221, 1),
              ],
              Color.fromRGBO(154, 154, 154, 1),
            ),
            items(
              height,
              width,
              "Videos",
              [
                Color.fromRGBO(221, 221, 221, 1),
                Color.fromRGBO(221, 221, 221, 1),
              ],
              Color.fromRGBO(154, 154, 154, 1),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBox(double height, double width) {
    return Container(
      height: height * 0.23,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/images/searchNature.png",
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.1,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 1),
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              EvaIcons.search,
            ),
            hintText: "Search socio club",
          ),
        ),
      ),
    );
  }

  Widget titleHeading(double height, double width, String title) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        left: width * 0.055,
        top: height * 0.02,
        bottom: height * 0.01,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<String> _images = [
    "assets/images/s9.jpg",
    "assets/images/s2.jpg",
    "assets/images/s4.jpg",
    "assets/images/s5.jpg",
    "assets/images/s6.jpg",
    "assets/images/s7.jpg",
    "assets/images/s8.jpg",
    "assets/images/s4.jpg",
    "assets/images/s5.jpg",
    "assets/images/s6.jpg",
    "assets/images/s7.jpg",
    "assets/images/s8.jpg",
  ];

  Widget participateItems(double height, double width, int i) {
    return Container(
      height: height * 0.1,
      width: width * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            _images[i],
          ),
        ),
      ),
    );
  }

  Widget participate(double height, double width) {
    return Container(
        height: height * 0.45,
        child: Swiper(
          viewportFraction: 0.75,
          scale: 0.9,
          scrollDirection: Axis.horizontal,
          layout: SwiperLayout.DEFAULT,
          itemCount: _images.length,
          itemHeight: height * 0.3,
          itemWidth: width * 0.7,
          itemBuilder: (context, int i) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  _images[i],
                                ),
                              )),
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(1, 0, 1, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black54,
                        backgroundImage: AssetImage(
                          "assets/images/profileImage2.png",
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
                          bottom: height * 0.02,
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
                      Container(
                        margin: EdgeInsets.only(
                          left: width * 0.019,
                          right: width * 0.019,
                          bottom: height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            participateItems(height, width, 6),
                            participateItems(height, width, 0),
                            participateItems(height, width, 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            // Container(
            //   height: height * 0.25,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage(
            //           _images[i],
            //         ),
            //       )),
            // );
          },
        ));
  }

  Widget contestes(double height, double width, String title, String image,
      String buttontitle, String imageleading, Function fun) {
    return Container(
      height: height * 0.3,
      width: width * 0.5,
      margin: EdgeInsets.only(left: width * 0.04),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    image,
                  ),
                )),
          ),
          Positioned(
              top: height * 0.005,
              left: width * 0.02,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: height * 0.06,
                      width: width * 0.08,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(imageleading)),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  )
                ],
              )),
          Positioned(
            top: height * 0.24,
            left: width * 0.14,
            child: GestureDetector(
              onTap: () {
                fun();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color.fromRGBO(255, 255, 255, 0.4)),
                height: height * 0.04,
                width: width * 0.23,
                alignment: Alignment.center,
                child: Text(
                  buttontitle,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget gamesItems(double height, double width) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contestes(
              height,
              width,
              "Pubg",
              "assets/images/s9.jpg",
              "Play now",
              "assets/images/trophy.png",
              () {},
            ),
            contestes(
              height,
              width,
              "BGMI",
              "assets/images/s8.jpg",
              "Play now",
              "assets/images/trophy.png",
              () {},
            ),
            contestes(
              height,
              width,
              "COD",
              "assets/images/s9.jpg",
              "Play now",
              "assets/images/trophy.png",
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget videoItems(double height, double width, String title, String image) {
    return Container(
      height: height * 0.42,
      width: width * 0.55,
      margin: EdgeInsets.only(
        left: width * 0.04,
        bottom: height * 0.02,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 6),
              blurRadius: 16,
              spreadRadius: 3)
        ],
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            image,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.01,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/profileImage2.png",
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget videos(double height, double width) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            videoItems(height, width, "User 1", _images[0]),
            videoItems(height, width, "User 2", _images[1]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbarOfHOmepage(height, width),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              searchBox(height, width),
              optionsWidget(height, width),
              SizedBox(
                height: height * 0.01,
              ),
              postSwiperWidget(height, width),
              titleHeading(
                height,
                width,
                "Contests",
              ),
              participate(height, width),
              SizedBox(
                height: height * 0.012,
              ),
              titleHeading(
                height,
                width,
                "Games",
              ),
              gamesItems(height, width),
              titleHeading(
                height,
                width,
                "Videos",
              ),
              videos(height, width),
              SizedBox(
                height: height * 0.12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
