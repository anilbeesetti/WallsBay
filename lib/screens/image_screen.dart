import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:wallsy/widgets/download_button.dart';
import 'package:wallsy/widgets/set_wallpaper_button.dart';

class ImageScreen extends StatefulWidget {
  final int id;
  final Function getPhotoFunction;
  final String placeHolderImage;

  const ImageScreen(
      {Key key,
      this.id,
      @required this.getPhotoFunction,
      this.placeHolderImage})
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Hero(
                    tag: widget.placeHolderImage,
                    child: CachedNetworkImage(
                      imageUrl: photoData.image.portrait,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height,
                      placeholder: (context, url) => Stack(
                        children: [
                          Image.network(
                            widget.placeHolderImage,
                            width: size.width,
                            height: size.height,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ),
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
