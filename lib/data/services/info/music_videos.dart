import 'package:dio/dio.dart';

import '../../../constants/api/api_key.dart';
import '../../models/info/music_videos_model.dart';

class MusicVideosService {
  static Future<List<MusicVideosModel>> getMusicVideos(
      {required int malId}) async {
    try {
      final response = await Dio().get(
        ApiKey.apiBaseUrlInfoAnimeVideos(malId: malId),
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data']['music_videos'] as List;
        return data.map((e) => MusicVideosModel.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e);
    }
    return [];
  }
}
