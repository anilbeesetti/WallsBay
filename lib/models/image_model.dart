class ImageModel {
  final String original;
  final String portrait;
  final String landscape;
  final String large;
  final String medium;

  const ImageModel(
      {this.medium, this.large, this.original, this.portrait, this.landscape});
}

class PhotoObjectModel {
  final int imageId;
  final ImageModel image;
  final String photographerName;
  final String photographerUrl;
  final int photographerId;

  const PhotoObjectModel(
      {this.photographerUrl,
      this.imageId,
      this.image,
      this.photographerName,
      this.photographerId});
}

class CategoryModel {
  final String categoryName;
  final String categoryImageUrl;

  CategoryModel({this.categoryName, this.categoryImageUrl});
}
