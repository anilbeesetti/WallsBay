import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ndialog/ndialog.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallsy/models/image_model.dart';

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
    setState(() {
      photoData = widget.getPhotoFunction(widget.id);
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    FlatButton.icon(
                      icon: Icon(Icons.download_outlined),
                      label: Text('Download'),
                      onPressed: () {
                        SimpleDialog(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.file_download,
                                ),
                                title: Text('Download Orginal Image'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.file_download,
                                ),
                                title: Text('Download Portrait Image'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.file_download,
                                ),
                                title: Text('Download Landscape Image'),
                              ),
                            ),
                          ],
                        ).show(context);
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.wallpaper_outlined),
                      label: Text('Set as Wallpaper'),
                      onPressed: () {
                        SimpleDialog(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: Text(
                                'Set Wallpaper',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                int location = WallpaperManager.HOME_SCREEN;
                                var file = await DefaultCacheManager()
                                    .getSingleFile(photoData.image.portrait);
                                String result;
                                try {
                                  result = await WallpaperManager
                                      .setWallpaperFromFile(
                                          file.path, location);
                                } on PlatformException {
                                  result = "Failed to get Wallpaper.";
                                }
                                Toast.show(result, context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              },
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.home_outlined,
                                  color: Colors.blue[700],
                                ),
                                title: Text('Home screen'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                int location = WallpaperManager.LOCK_SCREEN;
                                var file = await DefaultCacheManager()
                                    .getSingleFile(photoData.image.portrait);
                                String result;
                                try {
                                  result = await WallpaperManager
                                      .setWallpaperFromFile(
                                          file.path, location);
                                } on PlatformException {
                                  result = "Failed to get Wallpaper.";
                                }
                                Toast.show(result, context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              },
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue[700],
                                ),
                                title: Text('Lock screen'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                int location = WallpaperManager.BOTH_SCREENS;
                                var file = await DefaultCacheManager()
                                    .getSingleFile(photoData.image.portrait);
                                String result;
                                try {
                                  result = await WallpaperManager
                                      .setWallpaperFromFile(
                                          file.path, location);
                                } on PlatformException {
                                  result = "Failed to get Wallpaper.";
                                }
                                Toast.show(result, context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              },
                              child: ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.blue[700],
                                ),
                                title: Text('Home screen and lock screen'),
                              ),
                            ),
                          ],
                        ).show(context);
                      },
                    ),
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
