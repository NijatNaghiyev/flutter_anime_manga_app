import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/anime/recent_reviews_anime_model.dart';

class RecentReviewsAnimeService {
  Future<List<RecentReviewsAnimeModel>> getReviewsAnimeList() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlRecentReviewsAnime,
      );
      if (response.statusCode == HttpStatus.ok) {
        final list = response.data['data'] as List;

        return list
            .map((e) =>
                RecentReviewsAnimeModel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<RecentReviewsAnimeModel>();
      }
    } on DioException catch (e) {
      log("${e.message} Reviews Anime");
    }

    return [];
  }
}
