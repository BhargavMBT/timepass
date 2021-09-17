import 'dart:io';
import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

import 'package:timepass/Screens/message_screen.dart';

class Participate extends StatefulWidget {
  const Participate({Key? key}) : super(key: key);

  @override
  _ParticipateState createState() => _ParticipateState();
}

class _ParticipateState extends State<Participate> {
  List<String> _images = [
    "assets/images/nature.jpg",
    "assets/images/nature2.jpg",
    "assets/images/nature3.jpg",
    "assets/images/nature4.jpg",
  ];

  Widget container(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.009,
      ),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600]!,
              blurRadius: 0.07,
              spreadRadius: 0.07,
            )
          ],
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                _images[Random().nextInt(4)],
              ))),
    );
  }

  Widget gridview(double height, double width) {
    return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: 8,
        padding: EdgeInsets.only(
          left: width * 0.02,
          right: width * 0.02,
        ),
        itemBuilder: (BuildContext context, int i) {
          return container(height, width);
        },
        crossAxisSpacing: width * 0.02,
        mainAxisSpacing: height * 0.025,
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isOdd ? 1 : 1.4);
        });
  }

  Widget imageContainer(double height, double width) {
    return Container(
        height: height * 0.25,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/participate.png",
        ));
  }

  Widget addPhotoButton(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.015,
      ),
      height: height * 0.05,
      width: width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(51, 51, 51, 0.86),
      ),
      alignment: Alignment.center,
      child: Text(
        "Add photo",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
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
        backgroundColor: Colors.white,
        title: Text(
          "Participate",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            imageContainer(height, width),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Photography",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: Text(
                "Submit your best photos and win prizes and meet people with same minds",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.66),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ParticipateContinue();
                  }));
                },
                child: addPhotoButton(height, width)),
            SizedBox(
              height: height * 0.01,
            ),
            gridview(height, width),
          ]),
        ),
      ),
    );
  }
}

class ParticipateContinue extends StatefulWidget {
  const ParticipateContinue({Key? key}) : super(key: key);

  @override
  _ParticipateContinueState createState() => _ParticipateContinueState();
}

class _ParticipateContinueState extends State<ParticipateContinue> {
  Widget imageContainer(double height, double width) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.black,
              width: 3,
            )),
        height: height * 0.25,
        width: width * 0.5,
        child: Image.asset(
          "assets/images/participate.png",
        ));
  }

  Widget continueButton(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.015,
      ),
      height: height * 0.06,
      width: width * 0.62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(51, 51, 51, 0.86),
      ),
      alignment: Alignment.center,
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
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
        backgroundColor: Colors.white,
        title: Text(
          "Participate",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Align(
                alignment: Alignment.center,
                child: imageContainer(height, width)),
            Text(
              "Photography",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: height * 0.04,
                left: width * 0.04,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "Description",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: height * 0.015,
                left: width * 0.04,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "This is a photography contest, partcipate in this contest by posting your photos and stand out in crowd and win prize",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.66),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Uploadparticipatecontent();
                      }));
                    },
                    child: continueButton(height, width)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Uploadparticipatecontent extends StatefulWidget {
  const Uploadparticipatecontent({Key? key}) : super(key: key);

  @override
  _UploadparticipatecontentState createState() =>
      _UploadparticipatecontentState();
}

class _UploadparticipatecontentState extends State<Uploadparticipatecontent> {
  File? file;

  void cameraOpenforImage() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        file = File(imageFile.path);
      });
    }
  }

  void galleryForImageOpen() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        file = File(imageFile.path);
      });
    }
  }

  Widget itemsofmedia(Icon icon, String title, Icon icon2, var fun) {
    return GestureDetector(
      onTap: () {
        fun();
      },
      child: ListTile(
        title: Text(title),
        leading: icon,
        trailing: icon2,
      ),
    );
  }

  Future mediaPickerDialog(double height, double width) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.15,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  margin: EdgeInsets.only(
                    left: width * 0.035,
                    top: height * 0.015,
                    bottom: height * 0.015,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select an image",
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                  ),
                ),

                itemsofmedia(
                  Icon(
                    EvaIcons.camera,
                    color: Colors.black87,
                  ),
                  'Camera',
                  Icon(
                    EvaIcons.chevronRight,
                    color: Colors.black87,
                  ),
                  cameraOpenforImage,
                ),
                itemsofmedia(
                  Icon(
                    EvaIcons.imageOutline,
                    color: Colors.black87,
                  ),
                  'Image Gallery',
                  Icon(
                    EvaIcons.chevronRight,
                    color: Colors.black87,
                  ),
                  galleryForImageOpen,
                ),
                // itemsofmedia(
                //     Icon(
                //       EvaIcons.video,
                //       color: Colors.black87,
                //     ),
                //     'Record video',
                //     Icon(
                //       EvaIcons.chevronRight,
                //       color: Colors.black87,
                //     ),
                //     null),
                // itemsofmedia(
                //     Icon(
                //       EvaIcons.videoOutline,
                //       color: Colors.black87,
                //     ),
                //     'Video Gallery',
                //     Icon(
                //       EvaIcons.chevronRight,
                //       color: Colors.black87,
                //     ),
                //     null),
              ]),
            ),
          );
        });
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
        backgroundColor: Colors.white,
        title: Text(
          "Add Photo",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(246, 246, 246, 1),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.015,
                      left: width * 0.01,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage(
                          "assets/images/profileImage2.png",
                        ),
                      ),
                      title: Text(
                        "Kartik",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.015,
                      left: width * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        file == null
                            ? GestureDetector(
                                onTap: () {
                                  mediaPickerDialog(height, width);
                                },
                                child: Container(
                                  height: height * 0.11,
                                  width: width * 0.21,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: height * 0.11,
                                width: width * 0.21,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    // image: AssetImage(
                                    //   "assets/images/s7.jpg",
                                    // ),
                                    image: FileImage(
                                      file!,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      file = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: height * 0.025,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: width * 0.035,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: "Write a caption",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.74),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.15,
                  vertical: height * 0.02,
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  "*It’s an paid contest . In order to submit you have to pay amount",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Uploadparticipatecontent();
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: height * 0.02,
                  ),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                          width * 0.68,
                          height * 0.06,
                        )),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(
                            51,
                            51,
                            51,
                            1,
                          ),
                        )),
                    onPressed: null,
                    icon: Icon(
                      EvaIcons.cloudUploadOutline,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
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
