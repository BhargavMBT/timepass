import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'participateScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(0, 0, 0, 0.07)),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Available Coins",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          'Assets/Images/coins.png',
                          height: 45,
                          width: 45,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Try our Contests",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                height: 130,
                width: MediaQuery.of(context).size.width / 2 - 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ParticipateContinue();
                      }));
                    },
                    child: Image.asset("Assets/Images/participate.png")),
              ),
              SizedBox(
                height: 10,
                width: 10,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                height: 130,
                width: MediaQuery.of(context).size.width / 2 - 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 5,
                  // ),
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ParticipateContinue();
                      }));
                    },
                    child: Image.asset("Assets/Images/contest3.png")),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Categories",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Row(
            children: [
              Column(children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      )),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ParticipateContinue();
                        }));
                      },
                      child: Image.asset("Assets/Images/participate.png")),
                ),
                Text(
                  "Photography",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                )
              ]),
              SizedBox(
                height: 10,
                width: 10,
              ),
              Column(children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      )),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ParticipateContinue();
                        }));
                      },
                      child: Image.asset("Assets/Images/contest3.png")),
                ),
                Text(
                  "Videos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                )
              ])
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2 - 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 5,
                        )),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ParticipateContinue();
                          }));
                        },
                        child: Image.asset("Assets/Images/memes.png")),
                  ),
                  Text(
                    "Memes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.2,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
                width: 10,
              ),
              Column(children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 5,
                      )),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ParticipateContinue();
                        }));
                      },
                      child: Image.asset("Assets/Images/nature.jpg")),
                ),
                Text(
                  "Nature",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                  ),
                )
              ])
            ],
          ),
          Stack(alignment: Alignment.bottomRight, children: [
            Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.bottomLeft,
              height: 100,
              width: MediaQuery.of(context).size.width / 2 - 30,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  )),
              // child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (BuildContext context) {
              //             return ParticipateContinue();
              //           }));
              //     },
              //     child: Image.asset("Assets/Images/nature.jpg")),
            ),
            Icon(Icons.add_box_rounded)
          ]),
        ],
      ),
    );
  }
}
