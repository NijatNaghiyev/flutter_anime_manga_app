import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/manga/manga_search_model.dart';

class MangaSearch {
  Future<MangaSearchModel?> searchManga({
    required String query,
    required String searchType,
    required String orderBy,
    int page = 1,
  }) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlManga,
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
        return MangaSearchModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}
