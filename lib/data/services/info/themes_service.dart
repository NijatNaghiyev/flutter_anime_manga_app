import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/themes_model.dart';

class ThemesService {
  static Future<ThemesModel?> getThemes({required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeThemes(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ThemesModel.fromJson(data);
      }
    } on DioException catch (e) {
      print(e);
    }
    return null;
  }
}
