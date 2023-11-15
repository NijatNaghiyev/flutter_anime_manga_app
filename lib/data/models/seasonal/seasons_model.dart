class SeasonsModel {
  final int year;
  final List<String> seasons;

  SeasonsModel({required this.year, required this.seasons});

  factory SeasonsModel.fromJson(Map<String, dynamic> json) {
    return SeasonsModel(
      year: json['year'],
      seasons: List<String>.from(json['seasons']),
    );
  }
}
