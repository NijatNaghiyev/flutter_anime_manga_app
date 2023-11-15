import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';

class AnimeImagesService {
  static Future<List> getAnimeImages({required int malId}) async {
    try {
      final response =
          await Dio().get(ApiKey.apiBaseUrlAnimeImages(malId: malId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => e['jpg']!['image_url']!).toList();
      }
    } on DioException catch (e) {
      log(e.message.toString() + 'Anime Images');
    }

    return [];
  }
}
