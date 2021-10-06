class ProfileModel {
  final String? postid;
  final String? body;
  final String? postUrl;
  final String? author;
  final String? type;
  ProfileModel({
    this.postid,
    this.author,
    this.body,
    this.postUrl,
    this.type,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      author: json["author"],
      body: json["body"],
      postUrl: json["post"],
      postid: json["_id"],
      type: json["type"],
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

class UserSearchModel {
  final String? name;
  final String? userid;
  final String? imageUrl;
  final String? phone;
  final List<dynamic>? connections;
  UserSearchModel({
    this.name,
    this.userid,
    this.imageUrl,
    this.phone,
    this.connections,
  });
  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      name: json["name"],
      userid: json["_id"],
      imageUrl: json["photourl"],
      phone: json["phone"],
      connections: json["connections"],
    );
  }
}
