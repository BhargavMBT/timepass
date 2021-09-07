// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:photofilters/photofilters.dart';

// class FilterImage extends StatefulWidget {
//   final File image;
//   final String filename;
//   FilterImage({required this.image, required this.filename});

//   @override
//   _FilterImageState createState() => _FilterImageState();
// }

// class _FilterImageState extends State<FilterImage> {
//   List<Filter> filters = presetFiltersList;
//   @override
//   Widget build(BuildContext context) {
//     return PhotoFilterSelector(
//       title: Text("Image Filter"),
//       filters: filters,
//       image: Image.file(widget.image),
//       filename: widget.filename,
//     );
//   }
// }
