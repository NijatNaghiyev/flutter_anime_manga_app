import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/people/people_search_model.dart';

class PeopleSearch {
  Future<PeopleSearchModel?> searchPeople({
    required String query,
    required String orderBy,
    int page = 1,
  }) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlPeople,
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
        queryParameters: {
          'q': query,
          'page': page,
          'sort': 'desc',
          if (orderBy != 'Default') 'order_by': orderBy,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return PeopleSearchModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return null;
  }
}
