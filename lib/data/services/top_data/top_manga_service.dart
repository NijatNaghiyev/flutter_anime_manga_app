import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/top_data/top_manga_model.dart';

class TopMangaService {
  Future<TopMangaModel?> getTopManga() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlTopManga,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return TopMangaModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return null;
  }
}
