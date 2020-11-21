import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:toast/toast.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:ndialog/ndialog.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key key,
    @required this.photoData,
  }) : super(key: key);

  final PhotoObjectModel photoData;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(Icons.download_outlined),
      label: Text('Download'),
      onPressed: () {
        SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                'Download',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            ListTileButton(
              id: photoData.imageId,
              title: 'Orginal Image',
              photo: photoData.image.original,
            ),
            ListTileButton(
              id: photoData.imageId,
              title: 'Portrait Image',
              photo: photoData.image.portrait,
            ),
            ListTileButton(
              id: photoData.imageId,
              title: 'Landscape Image',
              photo: photoData.image.landscape,
            ),
          ],
        ).show(context);
      },
    );
  }
}

class ListTileButton extends StatefulWidget {
  const ListTileButton({
    Key key,
    @required this.title,
    @required this.photo,
    @required this.id,
  }) : super(key: key);

  final String title;
  final String photo;
  final int id;

  @override
  _ListTileButtonState createState() => _ListTileButtonState();
}

class _ListTileButtonState extends State<ListTileButton> {
  _save(BuildContext context, String photo, int id) async {
    var response;
    Navigator.pop(context);
    try {
      response = await GallerySaver.saveImage(photo);
    } catch (e) {
      print(e);
      response = false;
    }
    Toast.show(response ? 'Download Complete' : 'Download Error', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _save(context, widget.photo, widget.id);
      },
      child: ListTile(
        minLeadingWidth: 10,
        leading: Icon(
          Icons.download_outlined,
          color: Colors.blue[700],
        ),
        title: Text(widget.title),
      ),
    );
  }
}
