class ImageModel {
  final String original;
  final String portrait;
  final String landscape;
  final String large;

  ImageModel({this.large, this.original, this.portrait, this.landscape});
}

class PhotoObjectModel {
  final int imageId;
  final ImageModel image;
  final String photographerName;
  final String photographerUrl;
  final int photographerId;

  PhotoObjectModel(
      {this.photographerUrl,
      this.imageId,
      this.image,
      this.photographerName,
      this.photographerId});
}
