import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:timepass/API/APIservices.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Screens/PostAddScreen.dart';
import 'package:timepass/Screens/StoryAddingScreen.dart';
import 'package:timepass/Screens/participateScreen.dart';

import 'package:timepass/Screens/profile_Screen.dart';
import 'package:timepass/Screens/storiesScreen.dart';
import 'package:timepass/Screens/yourStoriesScreen.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Utils/textStyles.dart';
import 'package:timepass/Utils/textTitleWidgets.dart';
import 'package:timepass/Widgets/animationWidget.dart';
import 'package:timepass/Widgets/backAerrowWidget.dart';
import 'package:timepass/Widgets/drawerWidget.dart';
import 'package:timepass/Widgets/moreWidget.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/Widgets/title_Widget.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/main.dart';
import 'package:timepass/models/memesModel.dart';
import 'package:timepass/models/profileModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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

  Future getMemes() async {
    try {
      var url = Uri.parse(memeUrl);
      var response;
      // if (xAccessToken != null) {

      // }
      response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  Future getpostSocioWallAPI() async {
    try {
      var url = Uri.parse(socioWallUrl);
      var data = await http.get(url);

      return data.body;
    } catch (e) {
      print(e.toString());

      // throw Exception("Soemthing went wrong");
    }
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
                        color: Theme.of(context).accentColor,
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
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget titleText() {
    return GradientText("Timepass",
        gradient: LinearGradient(colors: [
          Color.fromRGBO(253, 108, 108, 1),
          Color.fromRGBO(193, 152, 234, 1),
          Color.fromRGBO(147, 96, 255, 0.94),
        ]));
  }

  CardController cardController = CardController();
  @override
  void dispose() {
    cardController.removeListener();
    super.dispose();
  }

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );
// border for all 3 colors
  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromRGBO(38, 203, 255, 1),
      Color.fromRGBO(105, 128, 253, 1),
    ]),
    // border: Border.all(
    //   color: Color.fromRGBO(38, 203, 255, 1),
    // ),
    borderRadius: BorderRadius.circular(32),
  );

  Widget storyContainer(
      double height, double width, String image, String name, bool yourstory) {
    return Container(
      margin: EdgeInsets.only(right: width * 0.045),
      child: Column(
        children: [
          ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(3.2), //width of the border
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: yourstory
                      ? FutureBuilder(
                          future: APIServices().getProfile(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var jsonData = jsonDecode(snapshot.data);
                              UserProfile user = UserProfile.fromJson(jsonData);
                              return Container(
                                height: height * 0.08,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        user.imageurl!,
                                      ),
                                      fit: BoxFit.fill),
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                height: height * 0.08,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Icon(
                                  Icons.error,
                                ),
                              );
                            } else {
                              return Container(
                                  height: height * 0.08,
                                  width: width * 0.15,
                                  color: Theme.of(context).primaryColor);
                            }
                          },
                        )
                      : Container(
                          height: height * 0.08,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(image), fit: BoxFit.fill),
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: storyGradient,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            name,
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 11.5),
          )
        ],
      ),
    );
  }

  Widget storiesWidget(double height, double width) {
    return Container(
      height: height * 0.12,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: width * 0.02,
        top: height * 0.02,
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return YourStories();
                  // }));
                  navagtionRoute(context, YourStories());
                },
                child: storyContainer(
                  height,
                  width,
                  "Assets/Images/yourstory.png",
                  "Your story",
                  true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return StoriesScreen();
                  }));
                },
                child: storyContainer(height, width, "Assets/Images/story1.png",
                    "HypeSun_98", false),
              ),
              storyContainer(height, width, "Assets/Images/story2.png",
                  "KarolBary", false),
              storyContainer(
                  height, width, "Assets/Images/story3.png", "Waggles", false),
              storyContainer(
                  height, width, "Assets/Images/yourstory.png", "XYZ", false)
            ],
          )),
    );
  }

  Widget postSwiperWidget(double height, double width) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.04),
        child: FutureBuilder(
          // future: getMemes(),
          // future: getMemePosts(),
          future: getpostSocioWallAPI(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var jsonData = jsonDecode(snapshot.data)['data']['posts'];
              List<MemeModel> _posts = [];
              jsonData.forEach((element) {
                MemeModel post = MemeModel.fromJson(element["imagelink"]);
                _posts.add(post);
              });
              // // for (var u in jsonData['data']['children']) {
              // //   if (u["data"]["url"].contains('.jpg') ||
              // //       u["data"]["url"].contains('.png') ||
              // //       u["data"]["url"].contains('.gif')) {
              // //     MemeModel post = MemeModel.fromJson(u['data']['url']);
              // //     _posts.add(post);
              // //   }
              // // }
              // var data = jsonDecode(snapshot.data)["data"]["memes"];

              // List<MemeModel> _posts = [];
              // data.forEach((element) {
              //   MemeModel model = MemeModel.fromJson(element["url"]);
              //   _posts.add(model);
              // });
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              // _list[index].imageurl!,
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
                itemCount: _posts.length,
                itemWidth: width * 0.79,
                duration: 100,
                viewportFraction: 0.2,
                itemHeight: height * 0.56,
                layout: SwiperLayout.STACK,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else {
              return Center(child: circularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future navigationfunction() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return Participate();
    }));
  }

  Widget contestItems(double height, double width) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contestes(
              height,
              width,
              "Photography",
              "Assets/Images/s7.jpg",
              "Participate",
              "Assets/Images/trophy.png",
              navigationfunction,
            ),
            contestes(
              height,
              width,
              "Meme chat",
              "Assets/Images/s2.jpg",
              "Participate",
              "Assets/Images/trophy.png",
              navigationfunction,
            ),
            contestes(
              height,
              width,
              "Photography",
              "Assets/Images/s3.jpg",
              "Participate",
              "Assets/Images/trophy.png",
              navigationfunction,
            ),
          ],
        ),
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
              "Assets/Images/cod.png",
              "Play now",
              "Assets/Images/trophy.png",
              () {},
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // void initState(){
  //   getAllstories();
  //   super.initState();
  // }

  Future getAllstories() async {
    try {
      var url = Uri.parse('$weburl/stories/613f26e1404781e9513e423d');

      var response = await http.get(url, headers: {
        'x-access-token': xAccessToken!,
      });
      if (response.statusCode == 200) {
        print(xAccessToken);
        print(response.body);
      } else {
        throw Exception("something went wrong.");
      }
    } catch (e) {
      throw Exception("something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbarOfHOmepage(height, width, context),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              storiesWidget(height, width),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              postSwiperWidget(height, width),
              titleHeading(height, width, "Contests"),
              contestItems(height, width),
              titleHeading(height, width, "Games"),
              gamesItems(height, width),
              SizedBox(height: height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
   // Container(
              //   height: height * 0.55,
              //   width: double.infinity,
              //   padding: EdgeInsets.only(left: width * 0.04),
              //   alignment: Alignment.center,
              //   child: TinderSwapCard(
              //     cardController: cardController,
              //     swipeUp: true,
              //     swipeDown: true,
              //     orientation: AmassOrientation.left,
              //     totalNum: imageItems.length,
              //     animDuration: 100,
              //     stackNum: 3,
              //     swipeEdge: 2.0,
              //     maxWidth: width * 1.9,
              //     maxHeight: height * 1.9,
              //     minWidth: width * 1.8,
              //     minHeight: height * 1.8,
              //     cardBuilder: (context, index) => SizedBox(
              //       height: height,
              //       width: width,
              //       child: Stack(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(20),
              //             child: Image.asset(
              //               '${imageItems[index]}',
              //               fit: BoxFit.fill,
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(
              //               left: width * 0.028,
              //               top: height * 0.015,
              //             ),
              //             child: ListTile(
              //               leading: CircleAvatar(
              //                 backgroundImage: AssetImage(
              //                   "assets/images/story1.png",
              //                 ),
              //               ),
              //               title: Text(
              //                 "first lastname",
              //                 style: TextStyle(
              //                     fontSize: 16,
              //                     color: Color.fromRGBO(255, 255, 255, 1)),
              //               ),
              //             ),
              //           ),
              //           Positioned(
              //             top: height * 0.35,
              //             left: width * 0.65,
              //             child: Icon(
              //               Icons.share,
              //               color: Color.fromRGBO(255, 255, 255, 1),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     swipeUpdateCallback:
              //         (DragUpdateDetails details, Alignment align) {
              //       /// Get swiping card's alignment
              //       if (align.x < 0) {
              //         //Card is LEFT swiping
              //       } else if (align.x > 0) {
              //         //Card is RIGHT swiping
              //       }
              //     },
              //     swipeCompleteCallback:
              //         (CardSwipeOrientation orientation, int index) {
              //       /// Get orientation & index of swiped card!
              //     },
              //   ),
              // ),