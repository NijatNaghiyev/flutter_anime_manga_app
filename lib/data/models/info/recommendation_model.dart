class RecommendationModel {
  final int malId;
  final String title;
  final String imageUrl;
  final int? votes;

  RecommendationModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.votes,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        malId: json['entry']["mal_id"],
        title: json['entry']["title"],
        imageUrl: json['entry']['images']['jpg']["image_url"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "title": title,
        "image_url": imageUrl,
        "votes": votes,
      };
}
