import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:ndialog/ndialog.dart';

class SetWallpaperButton extends StatelessWidget {
  const SetWallpaperButton({
    Key key,
    @required this.photoData,
  }) : super(key: key);

  final PhotoObjectModel photoData;

  Future<void> setWallpaper(BuildContext context, int wallpaperLocation) async {
    Navigator.pop(context);
    int location = wallpaperLocation;
    var file =
        await DefaultCacheManager().getSingleFile(photoData.image.portrait);
    String result;
    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    } on PlatformException {
      result = "Failed to get Wallpaper.";
    }
    Toast.show(result, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(Icons.wallpaper_outlined),
      label: Text('Set as Wallpaper'),
      onPressed: () {
        SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                'Set Wallpaper',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            ListTileButton(
              title: 'Home screen',
              icon: Icon(
                Icons.home_outlined,
                color: Colors.blue[700],
              ),
              onPress: () {
                setWallpaper(context, WallpaperManager.HOME_SCREEN);
              },
            ),
            ListTileButton(
              title: 'Lock screen',
              icon: Icon(
                Icons.lock_outlined,
                color: Colors.blue[700],
              ),
              onPress: () {
                setWallpaper(context, WallpaperManager.LOCK_SCREEN);
              },
            ),
            ListTileButton(
              title: 'Home screen and lock screen',
              icon: Icon(
                Icons.phone_android_outlined,
                color: Colors.blue[700],
              ),
              onPress: () {
                setWallpaper(context, WallpaperManager.BOTH_SCREENS);
              },
            ),
          ],
        ).show(context);
      },
    );
  }
}

class ListTileButton extends StatelessWidget {
  const ListTileButton({
    Key key,
    this.onPress,
    this.title,
    this.icon,
  }) : super(key: key);

  final String title;
  final Function onPress;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ListTile(
        minLeadingWidth: 10,
        leading: icon,
        title: Text(title),
      ),
    );
  }
}
