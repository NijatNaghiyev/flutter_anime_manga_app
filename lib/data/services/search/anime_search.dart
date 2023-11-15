import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/anime/anime_search_model.dart';

final class AnimeSearch {
  Future<AnimeSearchModel?> searchAnime({
    required String query,
    required String searchType,
    required String orderBy,
    int page = 1,
  }) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlAnime,
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
        queryParameters: {
          'q': query,
          'page': page,
          'sfw': true, //! Filter out Adult entries
          if (searchType != 'Default') 'type': searchType,
          'sort': 'desc',
          if (orderBy != 'Default') 'order_by': orderBy,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return AnimeSearchModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}
