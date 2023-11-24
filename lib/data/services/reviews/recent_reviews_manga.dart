import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/manga/recent_reviews_manga_model.dart';

class RecentReviewsMangaService {
  Future<List<RecentReviewsMangaModel>> getReviewsMangaList() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlRecentReviewsManga,
      );
      if (response.statusCode == HttpStatus.ok) {
        final list = response.data['data'] as List;

        return list
            .map((e) =>
                RecentReviewsMangaModel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<RecentReviewsMangaModel>();
      }
    } on DioException catch (e) {
      log("${e.message} Reviews Manga");
    }

    return [];
  }
}
