import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/seasonal/seasons_model.dart';

class SeasonsService {
  Future<List<SeasonsModel>> getSeasons() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlSeason,
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => SeasonsModel.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return [];
  }
}
