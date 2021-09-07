import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timepass/Screens/message_screen.dart';

class EnableDisabledNotification extends StatefulWidget {
  const EnableDisabledNotification({Key? key}) : super(key: key);

  @override
  _EnableDisabledNotificationState createState() =>
      _EnableDisabledNotificationState();
}

class _EnableDisabledNotificationState
    extends State<EnableDisabledNotification> {
  Widget items(
    double height,
    double width,
    String title,
    Widget widget,
    IconData icon,
    List<Color> gradient,
  ) {
    return ListTile(
      leading: Container(
        height: height * 0.07,
        width: width * 0.1,
        decoration: BoxDecoration(
            shape: BoxShape.circle, gradient: LinearGradient(colors: gradient)),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: backAerrowButton(height, width),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Enable notifications",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(height: height * 0.04),
            items(
                height,
                width,
                "Enable / Disable notification",
                Switch(
                  trackColor: MaterialStateProperty.all(
                    Color.fromRGBO(71, 107, 181, 1),
                  ),
                  activeColor: Colors.white,
                  overlayColor: MaterialStateProperty.all(
                    Color.fromRGBO(71, 107, 181, 1),
                  ),
                  activeTrackColor: Color.fromRGBO(71, 107, 181, 1),
                  value: true,
                  onChanged: (value) {},
                ),
                EvaIcons.bellOutline,
                [
                  Color.fromRGBO(52, 190, 169, 1),
                  Color.fromRGBO(52, 190, 169, 0.54),
                ]),
          ])),
    );
  }
}
