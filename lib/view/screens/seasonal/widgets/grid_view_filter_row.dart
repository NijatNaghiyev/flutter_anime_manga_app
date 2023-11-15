import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/models/seasonal/seasonal_model.dart';

class GridViewFilterRow extends StatefulWidget {
  const GridViewFilterRow({super.key, required this.data});

  final List<SeasonalData> data;

  @override
  State<GridViewFilterRow> createState() => _GridViewFilterRowState();
}

class _GridViewFilterRowState extends State<GridViewFilterRow> {
  String? seasonDateNowSeasonalScreen;

  /// Get the season and year from the data
  void _getSeasonDate() {
    while (seasonDateNowSeasonalScreen == null) {
      for (var i = 0; i < widget.data.length; i++) {
        if (widget.data[i].season != null && widget.data[i].year != null) {
          seasonDateNowSeasonalScreen =
              '${widget.data[i].season} ${widget.data[i].year}';
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getSeasonDate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [Text(seasonDateNowSeasonalScreen!)],
      ),
    );
  }
}
