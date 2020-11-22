import 'package:flutter/material.dart';
import 'package:wallsy/screens/image_screen.dart';

class ImageTile extends StatelessWidget {
  final String imgUrl;
  final int id;
  final Function getFunction;

  const ImageTile(
      {Key key, @required this.imgUrl, this.id, @required this.getFunction})
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
                    placeHolderImage: imgUrl,
                  )),
        );
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  color: Colors.black38,
                )
              ]),
          child: Hero(
            tag: imgUrl,
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
