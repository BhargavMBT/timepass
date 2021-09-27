import 'dart:io';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/photofilters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Screens/PostData.dart';
import 'package:timepass/Screens/message_screen.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
// class SelectedPostScreen extends StatefulWidget {
//   File? file;
//   String? type;
//   SelectedPostScreen({Key? key, this.file, this.type})
//       : super(
//           key: key,
//         );
//
//   @override
//   _SelectedPostScreenState createState() => _SelectedPostScreenState();
// }
//
// class _SelectedPostScreenState extends State<SelectedPostScreen> {
//   String? fileName;
//   List<Filter> filters = presetFiltersList;
//   XFile? imageFile;
//   File? finalImage;
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: backAerrowButton(height, width)),
//         title: Text(
//           "Post",
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: height * 0.02,
//           ),
//           widget.file == null
//               ? Container(
//                   height: height * 0.5,
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Select image",
//                   ),
//                 )
//               : Container(
//                   height: height * 0.5,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           fit: BoxFit.fill,
//                           image: FileImage(
//                             widget.file!,
//                           ))),
//                 ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.only(bottom: height * 0.02),
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: width * 0.04,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         File imageFile = widget.file!;
//                         // ignore: unnecessary_null_comparison
//                         if (imageFile != null) {
//                           fileName = basename(imageFile.path);
//                           var image = imageLib.decodeImage(
//                               File(imageFile.path).readAsBytesSync());
//                           image = imageLib.copyResize(
//                             image!,
//                             width: 500,
//                             height: 500,
//                           );
//                           Map? imagefile = await Navigator.push(
//                             context,
//                             new MaterialPageRoute(
//                               builder: (context) => new PhotoFilterSelector(
//                                 appBarColor: Colors.white,
//                                 circleShape: false,
//                                 height: height * 0.5,
//                                 width: double.infinity,
//                                 title: Text(
//                                   "Image filter",
//                                   style: TextStyle(color: Colors.grey[800]!),
//                                 ),
//                                 image: image!,
//                                 filters: presetFiltersList,
//                                 filename: fileName!,
//                                 loader: Center(
//                                     child: CircularProgressIndicator(
//                                   backgroundColor: Colors.grey[800],
//                                   strokeWidth: 2.5,
//                                 )),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           );
//                           if (imagefile != null) {
//                             if (imagefile.containsKey('image_filtered')) {
//                               setState(() {
//                                 widget.file = imagefile['image_filtered'];
//                               });
//                             }
//                           }
//                         }
//                       },
//                       child: Container(
//                         height: height * 0.05,
//                         width: width * 0.3,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[800],
//                           gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Color.fromRGBO(38, 203, 255, 1),
//                                 Color.fromRGBO(38, 203, 255, 1),
//                                 Color.fromRGBO(105, 128, 253, 1),
//                                 Color.fromRGBO(105, 128, 253, 1),
//                               ]),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Filter",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: height * 0.05,
//                       width: width * 0.3,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: Colors.grey[800]!,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Edit",
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         if (widget.file != null) {
//                           Navigator.push(context, MaterialPageRoute(
//                               builder: (BuildContext context) {
//                             return PostData(
//                               file: widget.file,
//                             );
//                           }));
//                         }
//                       },
//                       child: Container(
//                         height: height * 0.05,
//                         width: width * 0.3,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[800],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Next",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class StoryVideoSelected extends StatefulWidget {
  final File? file;
  StoryVideoSelected({this.file});

  @override
  _StoryVideoSelectedState createState() => _StoryVideoSelectedState();
}

class _StoryVideoSelectedState extends State<StoryVideoSelected> {
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
    // await videoPlayerController.initialize();
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

  makeImageUrl() async {
    UploadTask storageTak = storage
        .child(
            'Users/Stories${userid}_${DateTime.now().toIso8601String().toString()}')
        .putFile(widget.file!);
    TaskSnapshot taskSnapshot = await storageTak.whenComplete(() {});
    String downLoadUrl = await taskSnapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  Future postaStory(BuildContext context) async {
    setState(() {
      isloading = true;
    });
    try {
      var url = Uri.parse('$weburl/stories/new');
      String imageUrl = await makeImageUrl();
      var response = await http.post(url, body: {
        "story": imageUrl,
        "type": "Video",
      }, headers: {
        'x-access-token': xAccessToken!,
      });

      if (response.statusCode == 200) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Story added successfully!"),
          ),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MyApp();
        }));
      } else if (response.statusCode == 201) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Story added successfully!"),
          ),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MyApp();
        }));
      } else {
        setState(() {
          isloading = false;
        });
        AuthService().errorDialog(context, "Something went wrong.");
      }
    } catch (e) {
      print(e.toString());
      AuthService().errorDialog(context, "Something went wrong.!");
    } finally {
      setState(() {
        isloading = false;
      });
    }
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
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  EvaIcons.music,
                  color: Colors.black,
                )),
          ],
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: height * 0.03,
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: width * 0.06,
                              right: width * 0.06,
                              top: height * 0.015,
                              bottom: height * 0.015,
                            )),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor.withOpacity(1),
                            )),
                        onPressed: () {
                          postaStory(context);
                        },
                        child: Text(
                          "Add a story",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
            isloading
                ? Center(
                    child: circularProgressIndicator(),
                  )
                : Container(),
          ],
        ));
  }
}
