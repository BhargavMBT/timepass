import 'package:flutter/material.dart';
import 'package:timepass/Utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Widget item(double height, double width, String imagepath, String title) {
    return Container(
      margin: EdgeInsets.only(
        left: width * 0.1,
      ),
      height: height * 0.1,
      child: Row(
        children: [
          Container(
            height: height * 0.1,
            width: width * 0.1,
            child: Image.asset(imagepath),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget moreFeatures(
    double height,
    double width,
  ) {
    return Container(
        height: height * 0.1,
        margin: EdgeInsets.only(
          left: width * 0.06,
          top: height * 0.06,
          bottom: height * 0.01,
        ),
        child: Row(
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                height: height * 0.08,
                width: width * 0.08,
                child: Image(
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/leadingIcon.png",
                  ),
                )),
            SizedBox(width: width * 0.025),
            Text(
              "More Features",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ));
  }

  Widget sizebox(double height, double width) {
    return SizedBox(
      height: height * 0.02,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: pcolor,
      child: Column(
        children: [
          moreFeatures(height, width),
          item(height, width, "assets/images/leadingIcon.png", "Anonymous"),
          sizebox(height, width),
          item(height, width, "assets/images/gameIcon.png", "Games"),
          sizebox(height, width),
          item(height, width, "assets/images/emojiIcon.png", "Trolls"),
        ],
      ),
    );
  }
}
