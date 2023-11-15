import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';
import 'package:flutter_anime_manga_app/data/models/info/anime_staff_model.dart';

class AnimeStaffService {
  static Future<List<AnimeStaffModel>> getAnimeStaff(
      {required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeStaff(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => AnimeStaffModel.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return [];
  }
}
