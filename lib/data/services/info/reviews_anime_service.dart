import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/data/models/info/review_model.dart';

import '../../../constants/api/api_key.dart';

class ReviewsAnimeService {
  static Future<List<ReviewModel>> getAnimeReviews({required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeReviews(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => ReviewModel.fromJson(e)).toList();
      }
    } on Exception catch (e) {
      print(e);
    }

    return [];
  }
}
