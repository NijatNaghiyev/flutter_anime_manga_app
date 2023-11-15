import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/manga/manga_full_model.dart';

class MangaFullService {
  Future<MangaFullModel?> getMangaFull({required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlMangaFull(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return MangaFullModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return null;
  }
}
