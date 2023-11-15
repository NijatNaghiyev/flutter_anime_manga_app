class ApiKey {
  ApiKey._();

  /// Search
  static const String apiBaseUrlAnime = 'https://api.jikan.moe/v4/anime';
  static const String apiBaseUrlManga = 'https://api.jikan.moe/v4/manga';
  static const String apiBaseUrlCharacters =
      'https://api.jikan.moe/v4/characters';
  static const String apiBaseUrlPeople = 'https://api.jikan.moe/v4/people';
  static const String apiBaseUrlUsers = 'https://api.jikan.moe/v4/users';

  ///Full
  static String apiBaseUrlAnimeFull({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/full';
  static String apiBaseUrlMangaFull({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/full';

  /// Info

  static String apiBaseUrlInfoAnimeCharacter({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/characters';

  static String apiBaseUrlInfoAnimeStaff({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/staff';
  static String apiBaseUrlInfoAnimeThemes({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/themes';
  static String apiBaseUrlInfoAnimeVideos({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/videos';
  static String apiBaseUrlInfoAnimeReviews({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/reviews';
  static String apiBaseUrlInfoAnimeRecommendations({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/recommendations';
  static String apiBaseUrlInfoAnimeNews({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/news';
  static String apiBaseUrlInfoAnimeStatistics({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/statistics';

  static String apiBaseUrlInfoMangaCharacter({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/characters';
  static String apiBaseUrlInfoMangaReviews({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/reviews';
  static String apiBaseUrlInfoMangaRecommendations({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/recommendations';
  static String apiBaseUrlInfoMangaNews({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/news';
  static String apiBaseUrlInfoMangaStatistics({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/statistics';

  /// Images
  static String apiBaseUrlAnimeImages({required int malId}) =>
      'https://api.jikan.moe/v4/anime/$malId/pictures';
  static String apiBaseUrlMangaImages({required int malId}) =>
      'https://api.jikan.moe/v4/manga/$malId/pictures';

  /// Seasonal
  static const String apiBaseUrlSeasonNow =
      'https://api.jikan.moe/v4/seasons/now';
  static const String apiBaseUrlSeason = 'https://api.jikan.moe/v4/seasons/';
  static const String apiBaseUrlSeasonUpcoming =
      'https://api.jikan.moe/v4/seasons/upcoming';

  /// Top Data
  static const String apiBaseUrlTopAnime = 'https://api.jikan.moe/v4/top/anime';
  static const String apiBaseUrlTopManga = 'https://api.jikan.moe/v4/top/manga';
  static const String apiBaseUrlTopPeople =
      'https://api.jikan.moe/v4/top/people';
  static const String apiBaseUrlTopCharacters =
      'https://api.jikan.moe/v4/top/characters';

  /// Get the image url
  static String getImageUrl({
    required String imageId,
  }) {
    return 'https://image.tmdb.org/t/p/w500$imageId';
  }

  /// Get the YouTube url
  static String getYouTubeUrl({required String videoId}) {
    return 'https://www.youtube.com/watch?v=$videoId';
  }
}
