import 'package:flutter/material.dart';
import 'package:wallsy/models/image_model.dart';

import 'image_tile.dart';

class GridViewPhotosBuilder extends StatelessWidget {
  const GridViewPhotosBuilder({
    Key key,
    @required ScrollController scrollController,
    this.itemCount,
    this.data,
    @required this.getPhoto,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final int itemCount;
  final List<PhotoObjectModel> data;
  final Function getPhoto;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          var photoData = data[index];
          return ImageTile(
            id: photoData.imageId,
            key: ValueKey(photoData.imageId),
            imgUrl: photoData.image.large,
            getFunction: getPhoto,
          );
        },
      ),
    );
  }
}
