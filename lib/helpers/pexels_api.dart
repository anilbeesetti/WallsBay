import 'dart:convert';
import 'dart:math';

import 'package:wallsy/keys/private_keys.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallsy/models/pexels_data.dart';

class PexelsApi {
  static String defaultUrl = 'https://api.pexels.com/v1/search';
  static String homeUrl = defaultUrl;
  static String searchUrl;
  static String apiKey = PrivateKey.apiKey;
  static List<String> _randomStrings = [
    'sky',
    'river',
    'sea',
    'nature',
    'bikes',
    'cars',
    'mountains',
    'space',
    'earth',
    'quotes',
    'design',
    'food'
  ];

  ///
  /// Making Request to PexelsApi using http package
  ///

  static Future<http.Response> _getResponse(String url) async {
    var response = await http.get(
      url,
      headers: {"Authorization": apiKey},
    );
    return response;
  }

  ///
  /// Saving Data to CustomModel
  ///

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
              medium: photo['src']['medium']),
          photographerName: photo['photographer'],
          photographerId: photo['photographer_id'],
          photographerUrl: photo['photographer_url'],
        ),
      );
    });
  }

  ///
  /// On App Start Get Images
  ///

  static Future<void> getHomeImages(String url) async {
    var index = Random().nextInt(_randomStrings.length);
    var finalUrl = url + '?per_page=16&query=${_randomStrings[index]}';
    var response = await _getResponse(finalUrl);
    var responseData = jsonDecode(response.body);
    PexelsApi.homeUrl = responseData['next_page'];
    _saveData(responseData, PexelsData.pexelsPhotosData);
  }

  static Future<void> updataHomeImges(String url) async {
    if (url != null) {
      var response = await _getResponse(url);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        PexelsApi.homeUrl = responseData['next_page'];
        _saveData(responseData, PexelsData.pexelsPhotosData);
      }
    }
  }

  ///
  /// Searching for images
  ///

  static Future<void> getSearchImages(String searchString, String url) async {
    var finalUrl = url + '?per_page=16&query=$searchString';
    PexelsData.searchPhotosData = [];

    var response = await _getResponse(finalUrl);
    var responseData = jsonDecode(response.body);
    PexelsApi.searchUrl = responseData['next_page'];
    _saveData(responseData, PexelsData.searchPhotosData);
  }

  ///
  /// [ Helper Functions ]
  ///

  static Future<void> updateSearchImages() async {
    if (searchUrl != null) {
      var response = await _getResponse(searchUrl);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        PexelsApi.searchUrl = responseData['next_page'];
        _saveData(responseData, PexelsData.searchPhotosData);
      }
    }
  }

  static PhotoObjectModel getHomePhoto(int id) {
    return PexelsData.pexelsPhotosData.firstWhere((photo) {
      if (photo.imageId == id) {
        return true;
      }
      return false;
    });
  }

  static PhotoObjectModel getSearchPhoto(int id) {
    return PexelsData.searchPhotosData.firstWhere((photo) {
      if (photo.imageId == id) {
        return true;
      }
      return false;
    });
  }
}
