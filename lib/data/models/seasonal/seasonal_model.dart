class SeasonalModel {
  final Pagination pagination;
  final List<SeasonalData> data;

  SeasonalModel({required this.pagination, required this.data});

  factory SeasonalModel.fromJson(Map<String, dynamic> json) {
    final pagination = Pagination(
      lastVisiblePage: json['pagination']['last_visible_page'],
      currentPage: json['pagination']['current_page'],
      hasNextPage: json['pagination']['has_next_page'],
    );

    final data = <SeasonalData>[];
    final list = json['data'] as List;
    for (var element in list) {
      data.add(SeasonalData(
        malId: element['mal_id'],
        type: element['type'],
        title: element['title'],
        imageUrl: element['images']['jpg']['image_url'],
        episodes: element['episodes'],
        aired: element['aired']['string'],
        score: element['score'],
        members: element['members'],
        genres: element['genres'].map((e) => e['name']).toList().cast<String>(),
        airing: element['airing'],
        season: element['season'],
        year: element['year'],
      ));
    }

    return SeasonalModel(pagination: pagination, data: data);
  }
}

class Pagination {
  final int lastVisiblePage;
  final int currentPage;
  final bool hasNextPage;

  Pagination(
      {required this.lastVisiblePage,
      required this.currentPage,
      required this.hasNextPage});
}

class SeasonalData {
  final int malId;
  final String title;
  final String imageUrl;
  final int? episodes;
  final String? aired;
  final num? score;
  final int members;
  final String type;
  final List<String> genres;
  final bool airing;
  final String? season;
  final int? year;

  SeasonalData({
    required this.malId,
    required this.type,
    required this.title,
    required this.imageUrl,
    required this.episodes,
    required this.aired,
    required this.score,
    required this.members,
    required this.genres,
    required this.airing,
    required this.season,
    required this.year,
  });
}
