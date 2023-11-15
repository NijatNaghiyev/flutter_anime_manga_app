import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/top_data/top_characters_model.dart';

class TopCharactersService {
  Future<TopCharactersModel?> getTopCharacters() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlTopCharacters,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return TopCharactersModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return null;
  }
}
