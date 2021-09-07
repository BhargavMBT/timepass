import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:photofilters/filters/subfilters.dart';

import 'dart:ui' as ui;
import 'package:timepass/Screens/SelectedpostScreen.dart';
import 'package:timepass/Screens/message_screen.dart';
import 'package:timepass/filtersData/filterColorData.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);

  @override
  _PostAddScreenState createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  void cameraOpenforImage() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SelectedPostScreen(
          file: File(imageFile.path),
        );
      }));
    }
  }

  void galleryForImageOpen() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return CustomeFilterScreen(
          file: File(imageFile.path),
        );
        // SelectedPostScreen(
        //   file: File(imageFile.path),
        // );
      }));
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

  Future sheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.32,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.02,
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: Divider(
                    color: Colors.black,
                    thickness: MediaQuery.of(context).size.height * 0.005,
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
                itemsofmedia(
                    Icon(
                      EvaIcons.video,
                      color: Colors.black87,
                    ),
                    'Record video',
                    Icon(
                      EvaIcons.chevronRight,
                      color: Colors.black87,
                    ),
                    null),
                itemsofmedia(
                    Icon(
                      EvaIcons.videoOutline,
                      color: Colors.black87,
                    ),
                    'Video Gallery',
                    Icon(
                      EvaIcons.chevronRight,
                      color: Colors.black87,
                    ),
                    null),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      sheet();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Add a Post",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800]!,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        onPressed: sheet,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class CustomeFilterScreen extends StatefulWidget {
  final File? file;
  CustomeFilterScreen({this.file});

  @override
  _CustomeFilterScreenState createState() => _CustomeFilterScreenState();
}

class _CustomeFilterScreenState extends State<CustomeFilterScreen> {
  // final GlobalKey _globalKey = GlobalKey();
  // final GlobalKey _globalKey2 = GlobalKey();
  // final GlobalKey _globalKey3 = GlobalKey();
  // final GlobalKey _globalKey4 = GlobalKey();
  // final GlobalKey _globalKey5 = GlobalKey();
  // final GlobalKey _globalKey6 = GlobalKey();

  void convertWidgetToImage(GlobalKey key) async {
    RenderRepaintBoundary? repaintBoundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await repaintBoundary!.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FinalScreen(
              imageData: uint8list,
            )));
  }

  final List<Map<String, dynamic>> _filterItems = [
    {"": Nofilter, "key": GlobalKey()},
    {"Purple": Purple, "key": GlobalKey()},
    {"Black and White": BlackandWhite, "key": GlobalKey()},
    {"Sepium": Sepium, "key": GlobalKey()},
    {"Old Times": OldTimes, "key": GlobalKey()},
    {"Cold life": ColdLife, "key": GlobalKey()},
    {"Sepia": SEPIA_MATRIX, "key": GlobalKey()},
    {"GrayScale": GREYSCALE_MATRIX, "key": GlobalKey()},
    {"Vintage": VINTAGE_MATRIX, "key": GlobalKey()},
    {"Sweet": SWEET_MATRIX, "key": GlobalKey()},
    {"cyan": Cyan, "key": GlobalKey()},
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: PageView.builder(
            reverse: true,
            itemCount: _filterItems.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Stack(
                  children: [
                    RepaintBoundary(
                      key: _filterItems[i]["key"],
                      child: Container(
                        height: height,
                        width: width,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(
                            _filterItems[i].values.first,
                          ),
                          child: Image.file(
                            widget.file!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      _filterItems[i].keys.first.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          convertWidgetToImage(_filterItems[i]["key"]);
                        },
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.15,
                          padding: EdgeInsets.all(height * 0.005),
                          child: Container(
                            height: height * 0.14,
                            width: width * 0.14,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class FinalScreen extends StatefulWidget {
  final Uint8List? imageData;
  FinalScreen({this.imageData});

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: backAerrowButton(height, width),
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                EvaIcons.music,
                color: Colors.black,
              )),
        ],
        title: Text(
          "Selected image",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: Colors.red,
        height: height,
        width: width,
        child: Image.memory(
          widget.imageData!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
