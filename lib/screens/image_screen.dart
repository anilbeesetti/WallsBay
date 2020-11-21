import 'package:flutter/material.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:wallsy/widgets/download_button.dart';
import 'package:wallsy/widgets/set_wallpaper_button.dart';

class ImageScreen extends StatefulWidget {
  final int id;
  final Function getPhotoFunction;

  const ImageScreen({Key key, this.id, @required this.getPhotoFunction})
      : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool isLoading = true;
  PhotoObjectModel photoData;

  @override
  void initState() {
    photoData = widget.getPhotoFunction(widget.id);
    setState(() {
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  photoData.image.portrait,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                  bottom: 20,
                  child: Card(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          DownloadButton(photoData: photoData),
                          SetWallpaperButton(photoData: photoData),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
