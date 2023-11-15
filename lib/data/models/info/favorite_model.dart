class FavoriteModel {
  final int malId;
  final String title;
  final String imageUrl;
  final String type;
  final String airingStart;

  FavoriteModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.type,
    required this.airingStart,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      malId: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      type: json['type'] as String,
      airingStart: json['airing_start'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'title': title,
      'image_url': imageUrl,
      'type': type,
      'airing_start': airingStart,
    };
  }
}
