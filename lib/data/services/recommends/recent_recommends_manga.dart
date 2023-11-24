import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/Manga/recent_recommends_Manga_model.dart';

class RecentRecommendsMangaService {
  Future<List<RecentRecommendsMangaModel>> getRecentRecommends() async {
    try {
      final response = await Dio().get(ApiKey.apiBaseUrlRecentRecommendsManga);
      if (response.statusCode == HttpStatus.ok) {
        final list = response.data['data'] as List;

        return list
            .map((e) =>
                RecentRecommendsMangaModel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<RecentRecommendsMangaModel>();
      }
    } on DioException catch (e) {
      log("${e.message} Recent Recommends Manga");
    }

    return [];
  }
}
