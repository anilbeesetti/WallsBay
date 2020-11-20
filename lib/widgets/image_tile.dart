import 'package:flutter/material.dart';
import 'package:wallsy/screens/image_screen.dart';

class ImageTile extends StatelessWidget {
  final String imgUrl;
  final String imgUrlPortrait;

  const ImageTile(
      {Key key, @required this.imgUrl, @required this.imgUrlPortrait})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageScreen(
                    imgUrl: imgUrlPortrait,
                  )),
        );
      },
      child: GridTile(
        child: Hero(
          tag: imgUrlPortrait,
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
      ),
    );
  }
}
