import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_anime_manga_app/constants/api/api_key.dart';

import '../../models/top_data/top_people_model.dart';

class TopPeopleService {
  Future<TopPeopleModel?> getTopPeople() async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlTopPeople,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return TopPeopleModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(e.message.toString());
    }

    return null;
  }
}
