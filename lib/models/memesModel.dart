class MemeModel {
  final String? imageurl;
  // final String? name;
  // final String? id;
  MemeModel({
    this.imageurl,
    // this.name,
    // this.id,
  });

  factory MemeModel.fromJson(String imageurl) {
    return MemeModel(imageurl: imageurl
        // imageurl: json["url"],
        // id: json["id"],
        // name: json["name"],
        );
  }
}
