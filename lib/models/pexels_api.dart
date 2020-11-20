import 'dart:convert';

import 'package:wallsy/keys/private_keys.dart';
import 'package:wallsy/models/image_model.dart';
import 'package:http/http.dart' as http;

class PexelsData {
  static String url = 'https://api.pexels.com/v1/curated';
  static String apiKey = PrivateKey.apiKey;
  static List<PhotoObjectModel> pexelsPhotosData = [];

  static Future<void> getImages(String url) async {
    var response = await http.get(
      url,
      headers: {"Authorization": apiKey},
    );
    var responseData = jsonDecode(response.body);
    PexelsData.url = responseData['next_page'];
    responseData['photos'].forEach((photo) {
      pexelsPhotosData.add(
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
}
