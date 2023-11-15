import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/top_data/top_anime_model.dart';

final class TopAnimeService {
  Future<TopAnimeModel?> getTopAnime({int page = 1}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlTopAnime,
        queryParameters: {
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return TopAnimeModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }
    return null;
  }
}
