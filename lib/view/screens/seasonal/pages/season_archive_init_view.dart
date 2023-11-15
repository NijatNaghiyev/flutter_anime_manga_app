import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/parameter_search_type.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/extensions/string.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_archive_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/seasonal/seasons_model.dart';
import '../../../../features/state/bloc/seasonal/season_archive/season_archive_bloc.dart';

class SeasonArchiveInitView extends StatefulWidget {
  const SeasonArchiveInitView({super.key, required this.data});

  final List<SeasonsModel> data;

  @override
  State<SeasonArchiveInitView> createState() => _SeasonArchiveInitViewState();
}

class _SeasonArchiveInitViewState extends State<SeasonArchiveInitView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final data = widget.data[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    data.year.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    for (var element in data.seasons)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primary.withOpacity(0.6),
                          ),
                          onPressed: () {
                            yearArchive.value = data.year;
                            seasonArchive.value = element;

                            context.read<SeasonArchiveBloc>().seasonalData = [];
                            context.read<SeasonArchiveBloc>().page = 1;
                            context
                                .read<SeasonArchiveBloc>()
                                .add(SeasonArchiveInitialEvent(
                                  type: ParameterSearchTypeAnime.Default,
                                  year: data.year,
                                  season: element,
                                ));
                          },
                          child: Text(
                            element.capitalize(),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
