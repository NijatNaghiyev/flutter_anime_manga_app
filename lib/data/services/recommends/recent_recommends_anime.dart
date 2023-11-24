import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/anime/recent_recommends_anime_model.dart';

class RecentRecommendsAnimeService {
  Future<List<RecentRecommendsAnimeModel>> getRecentRecommends() async {
    try {
      final response = await Dio().get(ApiKey.apiBaseUrlRecentRecommendsAnime);
      if (response.statusCode == HttpStatus.ok) {
        final list = response.data['data'] as List;

        return list
            .map((e) =>
                RecentRecommendsAnimeModel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<RecentRecommendsAnimeModel>();
      }
    } on DioException catch (e) {
      log("${e.message} Recent Recommends Anime");
    }

    return [];
  }
}
