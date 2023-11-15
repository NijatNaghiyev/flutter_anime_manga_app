import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';
import 'package:flutter_anime_manga_app/constants/enum/parameter_search_type.dart';

import '../../models/seasonal/seasonal_model.dart';

class SeasonArchiveService {
  Future<SeasonalModel> getSeasonArchive({
    required int year,
    required String season,
    int page = 1,
    ParameterSearchTypeAnime paraType = ParameterSearchTypeAnime.Default,
  }) async {
    try {
      final response = await Dio().get(
        '${ApiKey.apiBaseUrlSeason}$year/$season',
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
        queryParameters: {
          'page': page,
          'sfw': true,
          if (paraType != ParameterSearchTypeAnime.Default)
            'filter': paraType.name,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return SeasonalModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return SeasonalModel(
      pagination: Pagination(
        lastVisiblePage: 0,
        currentPage: 0,
        hasNextPage: false,
      ),
      data: [],
    );
  }
}
