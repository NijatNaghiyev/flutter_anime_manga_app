import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/info_character.dart';

class CharacterService {
  static Future<InfoCharacterModel?> getCharacter(
      {required int malId, required SearchType searchType}) async {
    try {
      final response = await Dio().get(
        searchType == SearchType.anime
            ? ApiKey.apiBaseUrlInfoAnimeCharacter(malId: malId)
            : ApiKey.apiBaseUrlInfoMangaCharacter(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return InfoCharacterModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString() + ' Character');
    }

    return null;
  }
}
