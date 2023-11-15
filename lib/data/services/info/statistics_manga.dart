import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/statistics_manga.dart';

class StatisticsMangaService {
  static Future<StatisticsMangaModel?> getStatisticsManga(
      {required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoMangaStatistics(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        return StatisticsMangaModel.fromJson(response.data['data']);
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }
}
