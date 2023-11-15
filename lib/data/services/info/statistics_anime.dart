import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/statistics_anime.dart';

class StatisticsAnimeService {
  static Future<StatisticsAnimeModel?> getStatisticsAnime(
      {required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeStatistics(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        return StatisticsAnimeModel.fromJson(response.data['data']);
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }
}
