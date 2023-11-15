import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';

class MangaImagesService {
  static Future<List> getMangaImages({required int malId}) async {
    try {
      final response =
          await Dio().get(ApiKey.apiBaseUrlMangaImages(malId: malId));

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => e['jpg']!['image_url']!).toList();
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return [];
  }
}
