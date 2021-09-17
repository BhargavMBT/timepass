import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:timepass/Screens/StoryAddingScreen.dart';
import 'package:timepass/Screens/chat_Screen.dart';
import 'package:timepass/Screens/home_Screen.dart';

import 'package:timepass/Screens/searchScreen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int item = 0;
  // List of all screens of bottom navigation bar
  List<Widget> _screens = [
    Hero(
      tag: "Home",
      child: HomeScreen(),
    ),
    SearchScreen(),
    StoryAdding(),
    Container(
      child: Text("Screen 4"),
      color: Colors.white,
      alignment: Alignment.center,
    ),
    ChatScreen(),
  ];

  Widget icon(IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: FloatingNavbar(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.028),
        borderRadius: 30,
        currentIndex: item,
        backgroundColor: Theme.of(context).accentColor,
        fontSize: 8.0,
        onTap: (index) {
          setState(() {
            item = index;
          });
        },
        selectedBackgroundColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).primaryColor,
        itemBorderRadius: 30,
        unselectedItemColor: Color.fromRGBO(103, 104, 109, 1),
        items: [
          FloatingNavbarItem(
            icon: EvaIcons.home,
          ),
          FloatingNavbarItem(
            icon: EvaIcons.searchOutline,
          ),
          FloatingNavbarItem(
            icon: Icons.add,
          ),
          FloatingNavbarItem(
            icon: EvaIcons.video,
          ),
          FloatingNavbarItem(
            icon: EvaIcons.messageCircle,
          ),
        ],
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   height: MediaQuery.of(context).size.height * 0.078,
      //   items: [
      //     icon(EvaIcons.home),
      //     icon(EvaIcons.searchOutline),
      //     icon(Icons.add),
      //     icon(
      //       EvaIcons.video,
      //     ),
      //     icon(
      //       EvaIcons.messageCircle,
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       item = index;
      //     });
      //   },
      //   backgroundColor: item == 4
      //       ? Color.fromRGBO(
      //           56,
      //           59,
      //           87,
      //           1,
      //         )
      //       : Colors.white,
      //   color: Color.fromRGBO(13, 11, 38, 1),
      //   buttonBackgroundColor: Colors.indigo[300],
      // ),
      body: _screens[item],
    );
  }
}
