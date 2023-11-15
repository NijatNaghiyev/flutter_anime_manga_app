import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/data/models/info/recommendation_model.dart';

import '../../../constants/api/api_key.dart';

class RecommendationsMangaService {
  static Future<List<RecommendationModel>> getRecommendations(
      {required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoMangaRecommendations(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => RecommendationModel.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e);
    }

    return [];
  }
}
