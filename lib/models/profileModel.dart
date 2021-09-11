import 'package:firebase_auth/firebase_auth.dart';

class ProfileModel {
  final String? postid;
  final String? body;
  final String? postUrl;
  final String? author;
  ProfileModel({
    this.postid,
    this.author,
    this.body,
    this.postUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      author: json["author"],
      body: json["body"],
      postUrl: json["post"],
      postid: json["_id"],
    );
  }
}

class UserProfile {
  final String? name;
  final String? imageurl;
  final List? connections;

  UserProfile({
    this.name,
    this.imageurl,
    this.connections,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      connections: json["connections"],
      imageurl: json["photourl"],
      name: json["name"],
    );
  }
}
