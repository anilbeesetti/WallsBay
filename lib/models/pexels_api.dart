import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wallsy/keys/private_keys.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:http/http.dart' as http;

class PexelsData {
  static String defaultHomeUrl = 'https://api.pexels.com/v1/curated';
  static String homeUrl = defaultHomeUrl;
  static String defaultSearchUrl = 'https://api.pexels.com/v1/search';
  static String searchUrl = defaultSearchUrl;
  static String apiKey = PrivateKey.apiKey;
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

  static Future<dynamic> _getResponse(String url) async {
    var response = await http.get(
      url,
      headers: {"Authorization": apiKey},
    );
    return jsonDecode(response.body);
  }

  static void _saveData(
      dynamic responseData, List<PhotoObjectModel> photosData) {
    responseData['photos'].forEach((photo) {
      photosData.add(
        PhotoObjectModel(
          imageId: photo['id'],
          image: ImageModel(
            original: photo['src']['original'],
            portrait: photo['src']['portrait'],
            landscape: photo['src']['landscape'],
            large: photo['src']['large'],
          ),
          photographerName: photo['photographer'],
          photographerId: photo['photographer_id'],
          photographerUrl: photo['photographer_url'],
        ),
      );
    });
  }

  static Future<void> getImages(String url) async {
    var responseData = await _getResponse(url);
    PexelsData.homeUrl = responseData['next_page'];
    _saveData(responseData, pexelsPhotosData);
  }

  static Future<void> searchImages(String searchString, String url) async {
    var finalUrl = url + '?query=$searchString';
    searchPhotosData = [];

    var responseData = await _getResponse(finalUrl);
    PexelsData.searchUrl = responseData['next_page'];
    _saveData(responseData, searchPhotosData);
  }

  static Future<void> updateImages() async {
    var responseData = await _getResponse(searchUrl);
    _saveData(responseData, searchPhotosData);
  }

  static PhotoObjectModel getHomePhoto(int id) {
    return pexelsPhotosData.firstWhere((photo) {
      if (photo.imageId == id) {
        return true;
      }
      return false;
    });
  }

  static PhotoObjectModel getSearchPhoto(int id) {
    return searchPhotosData.firstWhere((photo) {
      if (photo.imageId == id) {
        return true;
      }
      return false;
    });
  }
}
