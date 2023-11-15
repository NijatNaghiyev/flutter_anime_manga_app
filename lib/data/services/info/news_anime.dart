import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/news_model.dart';

class NewsAnimeService {
  static Future<List<NewsModel>> getNews({required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeNews(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => NewsModel.fromJson(e)).toList();
      }
    } on Exception catch (e) {
      print(e);
    }

    return [];
  }
}
