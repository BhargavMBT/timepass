import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';

import 'package:timepass/Screens/message_screen.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class StoryAdding extends StatefulWidget {
  const StoryAdding({Key? key}) : super(key: key);

  @override
  _StoryAddingState createState() => _StoryAddingState();
}

class _StoryAddingState extends State<StoryAdding> {
  TextEditingController captionController = TextEditingController();
  File? file;
  String? typeOfPost;
  void cameraOpenforImage() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        typeOfPost = "Image";
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
        typeOfPost = "Image";
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

  makeImageUrl() async {
    UploadTask storageTak = storage
        .child(
            'Users/profile_img_${userid}_${DateTime.now().toIso8601String().toString()}')
        .putFile(file!);
    TaskSnapshot taskSnapshot = await storageTak.whenComplete(() {});
    String downLoadUrl = await taskSnapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  Future postFuction() async {
    setState(() {
      loading = true;
    });
    try {
      if (file != null) {
        String imageurl = await makeImageUrl();
        var url = Uri.parse('$weburl/posts/new');

        var response = await http.post(url, body: {
          "post": imageurl,
          "body": captionController.text.isEmpty ? "" : captionController.text,
          "type": typeOfPost,
        }, headers: {
          'x-access-token': xAccessToken!,
        });

        if (response.statusCode == 200) {
          setState(() {
            loading = false;
            file = null;
            captionController.clear();
          });
        } else {
          setState(() {
            loading = false;
            file = null;
            captionController.clear();
          });
          // AuthService().errorDialog(
          //   context,
          //   "Oops! Something went wrong",
          // );
        }
      } else {
        AuthService().errorDialog(
          context,
          "Please select a post.",
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      AuthService().errorDialog(context, "Something went wrong!");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void galleryForVideoOpen() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        typeOfPost = "Video";
        file = File(imageFile.path);
      });
    }
  }

  void cameraForVideoOpen() async {
    Navigator.pop(context);
    XFile? imageFile =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        typeOfPost = "Video";
        file = File(imageFile.path);
      });
    }
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
                    "Select an file",
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
                    cameraForVideoOpen),
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
                  galleryForVideoOpen,
                ),
              ]),
            ),
          );
        });
  }

  Widget postanonymous(double height, double width) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Post as Anonymous",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          Switch(
            overlayColor: MaterialStateProperty.all(Colors.black),
            value: false,
            onChanged: (value) {},
            activeColor: Colors.black,
            trackColor: MaterialStateProperty.all(Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: backAerrowButton(height, width),
        // ),
        title: Text(
          "New Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              loading
                  ? SizedBox(
                      height: height * 0.01,
                    )
                  : Container(),
              loading
                  ? LinearProgressIndicator(
                      minHeight: height * 0.005,
                      backgroundColor: Colors.blue,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.black,
                      ),
                    )
                  : Container(),
              postanonymous(height, width),
              Container(
                margin: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                  top: height * 0.05,
                ),
                height: height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromRGBO(234, 234, 234, 1),
                ),
                child: Column(
                  children: [
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
                                      color: Colors.grey[100],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                )
                              : file != null && typeOfPost == "Image"
                                  ? Container(
                                      height: height * 0.13,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                            file!,
                                          ),
                                        ),
                                      ),
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            typeOfPost = null;
                                            file = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          size: height * 0.025,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    )
                                  : file != null && typeOfPost == "Video"
                                      ? Container(
                                          height: height * 0.13,
                                          width: width * 0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: VideoIntializeWidget(
                                                  file: file,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      typeOfPost = null;
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
                                              Align(
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return PostVideoPlayer(
                                                        file: file,
                                                      );
                                                    }));
                                                  },
                                                  child: Icon(
                                                    EvaIcons.playCircleOutline,
                                                    size: height * 0.025,
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      : GestureDetector(
                                          onTap: () {
                                            mediaPickerDialog(height, width);
                                          },
                                          child: Container(
                                            height: height * 0.11,
                                            width: width * 0.21,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.grey[100],
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.add_a_photo,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                          SizedBox(
                            width: width * 0.06,
                          ),
                          Expanded(
                            child: TextFormField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: "Write something here",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
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
              Container(
                margin:
                    EdgeInsets.only(bottom: height * 0.02, top: height * 0.04),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
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
                  onPressed: postFuction,
                  child: Text(
                    "Post",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoIntializeWidget extends StatefulWidget {
  final File? file;
  VideoIntializeWidget({this.file});

  @override
  _VideoIntializeWidgetState createState() => _VideoIntializeWidgetState();
}

class _VideoIntializeWidgetState extends State<VideoIntializeWidget> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(widget.file!);
    videoPlayerController.initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VideoPlayer(
        videoPlayerController,
      ),
    );
  }
}

class PostVideoPlayer extends StatefulWidget {
  final File? file;
  PostVideoPlayer({this.file});
  @override
  _PostVideoPlayerState createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Future initialize() async {
    videoPlayerController = VideoPlayerController.file(widget.file!);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      aspectRatio: 1,
      allowFullScreen: false,
      showControls: true,
      looping: false,
      placeholder: Center(
        child: circularProgressIndicator(),
      ),
    );
  }

  bool isloading = false;
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
          title: Text(
            "Selected video",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
