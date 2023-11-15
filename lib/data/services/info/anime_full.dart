import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/anime/anime_full_model.dart';

class AnimeFullService {
  Future<AnimeFullModel?> getAnimeFull({required int malId}) async {
    try {
      Response response = await Dio().get(
        ApiKey.apiBaseUrlAnimeFull(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return AnimeFullModel.fromJson(data);
      }
    } on DioException catch (e) {
      log('${e.message}AnimeFullService');
    }

    return null;
  }
}
