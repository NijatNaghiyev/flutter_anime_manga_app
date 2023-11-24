import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_anime.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_manga.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constants/enum/search_type.dart';
import '../../data/services/firestore_database/mylist_anime_store.dart';
import '../../data/services/firestore_database/mylist_manga_store.dart';
import '../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import 'bottom_sheet_anime_manga_title.dart';
import 'bottom_sheet_date_time.dart';
import 'bottom_sheet_delete_area.dart';
import 'bottom_sheet_input_chip_list.dart';
import 'bottom_sheet_progress_number.dart';
import 'bottom_sheet_score_number.dart';
import 'bottom_sheet_status_title_row.dart';
import 'center_loading_indicator.dart';

class EditListBottomSheet extends StatefulWidget {
  const EditListBottomSheet({
    super.key,
    required this.type,
    required this.mylistModel,
  });

  final SearchType type;
  final MylistModel mylistModel;

  @override
  State<EditListBottomSheet> createState() => _EditListBottomSheetState();
}

class _EditListBottomSheetState extends State<EditListBottomSheet> {
  late ValueNotifier<String> selectedStatusValueNotifier;

  int? userScore;
  int? userProgress;
  String? userStartDate;
  String? userEndDate;

  @override
  void initState() {
    super.initState();

    /// Initialize [selectedStatus] with [MylistModel.userStatus] if not null, else initialize with default value.
    if (widget.mylistModel.userStatus != null) {
      selectedStatusValueNotifier =
          ValueNotifier(widget.mylistModel.userStatus!);
    } else {
      selectedStatusValueNotifier = ValueNotifier(
        widget.type == SearchType.anime
            ? StatusAnime.planToWatch
            : StatusManga.planToRead,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM dd, yyyy');
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 70),
          height: MediaQuery.sizeOf(context).height * 0.9,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                /// Top Row
                buildBottomSheetTopRow(context),

                /// Title
                BottomSheetAnimeMangaTitle(widget: widget),
                const Divider(
                  height: 32,
                ),

                /// Status Row
                BottomSheetTitleRow(
                  title: 'Status',
                  value: widget.mylistModel.airingStart!.contains('to')
                      ? widget.mylistModel.airingStart!
                              .split('to')[1]
                              .contains('?')
                          ? 'Airing'
                          : 'Finished'
                      : '',
                ),

                /// Status List
                ValueListenableBuilder(
                  valueListenable: selectedStatusValueNotifier,
                  builder: (context, selectedStatus, _) {
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6.0,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: statusList(
                          type: widget.type,
                          selectedStatus: selectedStatus,
                          selectedStatusValueNotifier:
                              selectedStatusValueNotifier,
                          context: context),
                    );
                  },
                ),
                const Divider(
                  height: 32,
                ),
                ...[
                  BottomSheetTitleRow(
                    title: 'Progress',
                    value:
                        '${widget.mylistModel.episodesOrChapters ?? '??'} ${widget.type == SearchType.anime ? 'ep' : 'chp'}',
                  ),
                  BottomSheetProgressNumber(
                    widgetEditBottomSheet: widget,
                    onSelectedNumber: (selectedNumber) {
                      userProgress = selectedNumber;
                    },
                  ),
                ],
                const Divider(
                  height: 32,
                ),

                ...[
                  const BottomSheetTitleRow(
                    title: 'Score',
                    value: '',
                  ),
                  BottomSheetScoreNumber(
                    widgetEditBottomSheet: widget,
                    onSelectedNumber: (selectedNumber) {
                      userScore = selectedNumber;
                    },
                  ),
                ],
                const Divider(
                  height: 32,
                ),
                ...[
                  BottomSheetTitleRow(
                    title: 'Date',
                    value: widget.mylistModel.airingStart ?? '??',
                  ),
                  BottomSheetDateTime(
                    mylistModel: widget.mylistModel,
                    onStartDateChanged: (startDate) {
                      if (startDate == null) {
                        return;
                      }

                      userStartDate = formatter.format(startDate);
                    },
                    onFinishDateChanged: (finishDate) {
                      if (finishDate == null) {
                        return;
                      }

                      userEndDate = formatter.format(finishDate);
                    },
                  ),
                ],
              ],
            ),
          ),
        ),

        /// Delete Area
        BottomSheerDeleteArea(widget: widget),
      ],
    );
  }

  /// buildBottomSheetTopRow
  Row buildBottomSheetTopRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CloseButton(),
        TextButton(
          onPressed: () async {
            showGeneralDialog(
              barrierDismissible: false,
              useRootNavigator: false,
              barrierLabel: 'Search Loading',
              barrierColor: Colors.transparent,
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CenterLoadingIndicator(),
            );

            if (widget.type == SearchType.anime) {
              await MylistAnimeStore.saveMylist(
                mylistModel: widget.mylistModel.copyWith(
                  userStatus: selectedStatusValueNotifier.value,
                  userScore: userScore,
                  userProgress: userProgress,
                  userStartDate: userStartDate,
                  userEndDate: userEndDate,
                ),
              );
              if (!mounted) {
                return;
              }
              context.read<MylistAnimeBloc>().add(
                    const MylistAnimeLoadEvent(),
                  );
            } else if (widget.type == SearchType.manga) {
              await MylistMangaStore.saveMylist(
                mylistModel: widget.mylistModel.copyWith(
                  userStatus: selectedStatusValueNotifier.value,
                  userScore: userScore,
                  userProgress: userProgress,
                  userStartDate: userStartDate,
                  userEndDate: userEndDate,
                ),
              );
              if (!mounted) {
                return;
              }
              context.read<MylistMangaBloc>().add(
                    const MylistMangaLoadEvent(),
                  );
            }

            if (!mounted) {
              return;
            }

            /// For Dialog
            Navigator.pop(context);

            /// For BottomSheet
            Navigator.pop(context);
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: MyColors.primary,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
