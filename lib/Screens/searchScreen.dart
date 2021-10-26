import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/material.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Screens/otherUserProfileScreen.dart';
import 'package:timepass/Widgets/backAerrowWidget.dart';

import 'package:http/http.dart' as http;
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';
import 'package:timepass/models/memesModel.dart';
import 'package:timepass/models/profileModel.dart';

enum ScreenType { Search, Explore }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScreenType screenType = ScreenType.Explore;
  List<String> imageItems = [
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

  Future getMemePosts() async {
    try {
      var url = Uri.parse("https://www.reddit.com/r/memes.json");
      var data = await http.get(url);
      return data.body;
    } catch (e) {
      // throw Exception("Soemthing went wrong");
    }
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
                                    "Assets/Images/story1.png",
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
          color: Theme.of(context).accentColor,
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
            "Assets/Images/searchNature.png",
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
        child: textfield(height, width),
      ),
    );
  }

  TextEditingController controller = TextEditingController();

  Widget textfield(double height, double width) {
    return TextFormField(
      onFieldSubmitted: (String? value) {
        if (value != null) {
          searchUsers(value);
        }
      },
      onChanged: (String? value) {
        if (value!.trim().isNotEmpty) {
          if (screenType == ScreenType.Explore) {
            setState(() {
              screenType = ScreenType.Search;
            });
          }
        }
      },
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: controller.text.trim().isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    controller.clear();
                    screenType = ScreenType.Explore;
                  });
                },
                icon: Icon(
                  Icons.cancel,
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
        border: InputBorder.none,
        prefixIcon: Icon(
          EvaIcons.search,
        ),
        hintText: "Search socio club",
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
          color: Theme.of(context).accentColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

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
                          "Assets/Images/profileImage2.png",
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Photography",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
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
                            color: Theme.of(context).accentColor,
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
                        color: Theme.of(context).primaryColor,
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
              "Assets/Images/s9.jpg",
              "Play now",
              "Assets/Images/trophy.png",
              () {},
            ),
            contestes(
              height,
              width,
              "BGMI",
              "Assets/Images/s8.jpg",
              "Play now",
              "Assets/Images/trophy.png",
              () {},
            ),
            contestes(
              height,
              width,
              "COD",
              "Assets/Images/s9.jpg",
              "Play now",
              "Assets/Images/trophy.png",
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
              "Assets/Images/profileImage2.png",
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).accentColor,
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

  List<UserSearchModel>? _usersearchModel = [];
  Future searchUsers(String query) async {
    try {
      setState(() {
        isloading = true;
      });
      var url = Uri.parse('$weburl/users/search?searchQuery=$query');
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
            isloading = false;
          });
        } else {
          print(response.statusCode);
          AuthService().errorDialog(context, "Oops! Something went wrong");
        }
      } else {
        AuthService().errorDialog(context, "Oops! Something went wrong");
      }
    } catch (e) {
      AuthService().errorDialog(context, "Oops! Something went wrong");
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  Widget searchResultWidget(double height, double width) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
      ),
      color: Colors.white,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _usersearchModel!.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return OtherUserProfileScreen(
                    name: _usersearchModel![i].name,
                    connections: _usersearchModel![i].connections,
                    connectionsLength:
                        _usersearchModel![i].connections!.length.toString(),
                    id: _usersearchModel![i].userid,
                    imageurl: _usersearchModel![i].imageUrl,
                  );
                }));
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: height * 0.02,
                  backgroundImage: CachedNetworkImageProvider(
                      _usersearchModel![i].imageUrl!),
                ),
                title: Text(_usersearchModel![i].name!),
              ),
            );
          }),
    );
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appbarOfHOmepage(height, width, context),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: screenType == ScreenType.Explore
                  ? Column(
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
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.1,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: textfield(height, width),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        searchResultWidget(height, width)
                      ],
                    ),
            ),
          ),
          isloading
              ? Center(
                  child: circularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
