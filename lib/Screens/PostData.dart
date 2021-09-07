import 'dart:io';

import 'package:flutter/material.dart';
import 'package:timepass/Screens/message_screen.dart';

class PostData extends StatefulWidget {
  final File? file;
  PostData({this.file});

  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  OutlineInputBorder border() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: backAerrowButton(height, width)),
        title: Text(
          "Post",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    widget.file!,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.05,
              ),
              child: TextFormField(
                  maxLength: 250,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Enter a caption',
                      labelText: "Caption",
                      labelStyle: TextStyle(color: Colors.black),
                      border: border(),
                      focusedBorder: border()),
                  cursorColor: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.01,
              ),
              child: TextFormField(
                  decoration: InputDecoration(
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_on,
                        ),
                      ),
                      hintText: 'Enter a location',
                      labelText: "Location",
                      labelStyle: TextStyle(color: Colors.black),
                      border: border(),
                      focusedBorder: border()),
                  cursorColor: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return PostData();
                }));
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: height * 0.03, bottom: height * 0.03),
                height: height * 0.06,
                width: width * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[500]!,
                        Colors.grey[800]!,
                      ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
