import 'image_model.dart';

class PexelsData {
  static List<PhotoObjectModel> pexelsPhotosData = [];
  static List<PhotoObjectModel> searchPhotosData = [];
  static List<CategoryModel> categoryList = [
    CategoryModel(
      categoryName: 'Street Art',
      categoryImageUrl:
          "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    ),
    CategoryModel(
      categoryName: 'Nature',
      categoryImageUrl:
          "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    ),
    CategoryModel(
      categoryName: 'City',
      categoryImageUrl:
          "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    ),
    CategoryModel(
      categoryName: 'Motivation',
      categoryImageUrl:
          "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
    ),
    CategoryModel(
      categoryName: 'Bikes',
      categoryImageUrl:
          "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    ),
    CategoryModel(
      categoryName: 'Cars',
      categoryImageUrl:
          "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    ),
  ];
}
