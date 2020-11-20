import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imgUrl;

  const ImageScreen({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: imgUrl,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
