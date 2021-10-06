import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timepass/API/BasicAPI.dart';
import 'package:timepass/Authentication/authServices.dart';
import 'package:timepass/Utils/colors.dart';
import 'package:timepass/Utils/textTitleWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/Widgets/bottomNavigationWidget.dart';
import 'package:timepass/Widgets/progressIndicators.dart';
import 'package:timepass/main.dart';

class CreateUserProfile extends StatefulWidget {
  final String? name;
  final String? imageurl;
  final String? userid;
  final String? email;
  final String? typeOfSignup;
  final String? phoneNumber;

  CreateUserProfile({
    this.name,
    this.imageurl,
    this.email,
    this.userid,
    this.typeOfSignup,
    this.phoneNumber,
  });

  @override
  _CreateUserProfileState createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.name != null) {
      controller.text = widget.name!;
    }
    super.initState();
  }

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
              ]),
            ),
          );
        });
  }

  makeImageUrl() async {
    UploadTask storageTak = storage
        .child(
            'Users/profile_img_${widget.userid}_${DateTime.now().toIso8601String().toString()}')
        .putFile(file!);
    TaskSnapshot taskSnapshot = await storageTak.whenComplete(() {});
    String downLoadUrl = await taskSnapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: accent,
      ),
    );
  }

  imageheader(double height, double width) {
    return Stack(
      children: [
        Container(
            height: height * 0.15,
            width: width * 0.3,
            decoration: widget.imageurl == null
                ? file == null
                    ? BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      )
                    : BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(file!),
                        ),
                      )
                : widget.imageurl != null && file != null
                    ? BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(file!),
                        ),
                      )
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.imageurl!,
                          ),
                        ),
                      )),
        Positioned(
          top: height * 0.08,
          right: width * 0.01,
          child: GestureDetector(
            onTap: () {
              mediaPickerDialog(height, width);
            },
            child: Container(
              height: height * 0.08,
              width: width * 0.08,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 0.5,
                ),
                color: prime,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                EvaIcons.edit,
                size: height * 0.022,
              ),
            ),
          ),
        )
      ],
    );
  }

  nameTextfiled(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.06),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: border(),
          focusedBorder: border(),
          errorBorder: border(),
          disabledBorder: border(),
          hintText: "Enter your name.",
          labelText: "Name",
        ),
      ),
    );
  }

  Future postUserData() async {
    print(controller.text);
    print(widget.name);
    setState(() {
      loading = true;
    });
    try {
      if (widget.imageurl != null || file != null) {
        if (controller.text.isNotEmpty) {
          var url = Uri.parse('$weburl/user/othersignup');
          String photoUrl =
              file != null ? await makeImageUrl() : widget.imageurl;

          var response = await http.post(url, body: {
            'email': widget.email,
            'name': controller.text,
            'phone': widget.phoneNumber,
            'photourl': photoUrl,
            'username': controller.text,
          });

          print(response.statusCode.toString());
          print(response.body);
          if (response.statusCode == 200) {
            print('Response body: ${response.body}');
            setState(() {
              xAccessToken = jsonDecode(response.body)['token'];
              userid = jsonDecode(response.body)["result"]["_id"];
              loading = false;
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return BottomNavigationBarWidget();
                },
              ),
            );
          } else {
            print("e");
            AuthService().errorDialog(
              context,
              "Oops! Something went wrong.",
            );
          }
        } else {
          AuthService().errorDialog(
            context,
            "Please enter a name.",
          );
        }
      } else {
        AuthService().errorDialog(
          context,
          "Select a profile image.",
        );
      }
    } catch (e) {
      print(e.toString());
      AuthService().errorDialog(
        context,
        "Oops! Something went wrong",
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
    // print('Response status: ${}');
  }

  button(double height, double width) {
    return GestureDetector(
      onTap: postUserData,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.25, vertical: height * 0.01),
        height: height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(111, 111, 111, 0.24),
                offset: Offset(8, 8),
                blurRadius: 44,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(35),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(39, 39, 39, 1),
              Color.fromRGBO(39, 39, 39, 0.28),
            ])),
        child: Text(
          "Create profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    print(widget.name.toString());
    print(widget.email.toString());
    print(widget.imageurl.toString());
    print(widget.userid.toString());
    print(widget.phoneNumber.toString());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      color: prime,
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              loading
                  ? SizedBox(
                      height: height * 0.04,
                    )
                  : Container(),
              loading
                  ? linearProgressIndicator(
                      height,
                    )
                  : Container(),
              SizedBox(
                height: height * 0.08,
              ),
              titleHeading(height, width, "Create your profile"),
              SizedBox(
                height: height * 0.05,
              ),
              imageheader(height, width),
              nameTextfiled(height, width),
              button(height, width),
            ]),
      ),
    );
  }
}
