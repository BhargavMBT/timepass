import 'package:flutter/material.dart';
import 'package:timepass/Screens/message_screen.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({Key? key}) : super(key: key);

  @override
  _MoreWidgetState createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  Widget items(double height, double width, String title, String image) {
    return Container(
        alignment: Alignment.centerRight,
        height: height * 0.35,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Container(
              height: height * 0.32,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            Positioned(
              right: width * 0.06,
              top: height * 0.03,
              child: Container(
                height: height * 0.27,
                width: width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 21,
                        spreadRadius: 0,
                      )
                    ]),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  bottom: height * 0.015,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Positioned(
              right: width * 0.22,
              bottom: height * 0.1,
              child: Container(
                height: height * 0.22,
                width: width * 0.6,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 21,
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        image,
                      ),
                    )),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: backAerrowButton(height, width)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "More",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                items(height, width, "Trolls", "assets/images/trolls.png"),
                items(height, width, "Anonymous", "assets/images/trolls.png"),
                items(height, width, "Contest's", "assets/images/trolls.png"),
                items(height, width, "Leaderboard", "assets/images/trolls.png"),
              ],
            ),
          )),
    );
  }
}
