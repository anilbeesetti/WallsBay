import 'package:flutter/material.dart';
import 'package:wallsy/screens/image_screen.dart';

class ImageTile extends StatelessWidget {
  final String imgUrl;
  final String imgUrlPortrait;
  final int id;
  final Function getFunction;

  const ImageTile(
      {Key key,
      @required this.imgUrl,
      @required this.imgUrlPortrait,
      this.id,
      @required this.getFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageScreen(
                    id: id,
                    getPhotoFunction: getFunction,
                  )),
        );
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
