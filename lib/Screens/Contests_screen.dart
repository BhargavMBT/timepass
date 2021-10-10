import 'package:flutter/material.dart';

class ContestsScreen extends StatelessWidget {
  const ContestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Contests"),
          ],
        ),
      ),
      body: Contests(),
    );
  }
}

class Contests extends StatefulWidget {
  const Contests({Key? key}) : super(key: key);

  @override
  _ContestsState createState() => _ContestsState();
}

class _ContestsState extends State<Contests> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
          width: double.infinity,
        ),
        Row(children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 150.0,
            width: MediaQuery.of(context).size.width - 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("Assests/Images/coins.png"),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey),
            child: Row(
              children: [
                Text(
                  "Available Coins",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ])
      ],
    );
  }
}
