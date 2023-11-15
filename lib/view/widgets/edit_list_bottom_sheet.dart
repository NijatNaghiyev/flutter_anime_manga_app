import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_anime.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_manga.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../constants/enum/search_type.dart';
import '../../data/services/firestore_database/mylist_anime_store.dart';
import '../../data/services/firestore_database/mylist_manga_store.dart';
import '../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
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
  late ValueNotifier<String> selectedStatus;
  int? userScore;
  int? userProgress;
  String? userStartDate;
  String? userEndDate;

  /// List of [InputChip] for status.
  List<ChoiceChip> statusList(
      {required SearchType type, required String selectedStatus}) {
    if (type == SearchType.anime) {
      return StatusAnime.statusList.map((e) {
        return ChoiceChip(
          label: Text(
            e,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
          selected: selectedStatus == e,
          color: selectedStatus == e
              ? MaterialStatePropertyAll(
                  StatusColors.statusColors[StatusAnime.statusList.indexOf(e)])
              : MaterialStatePropertyAll(
                  Theme.of(context).scaffoldBackgroundColor,
                ),
          showCheckmark: false,
          onSelected: (bool value) {
            this.selectedStatus.value = e;
          },
        );
      }).toList();
    } else if (type == SearchType.manga) {
      return StatusManga.statusList.map((e) {
        return ChoiceChip(
          label: Text(
            e,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
          selected: selectedStatus == e,
          color: selectedStatus == e
              ? MaterialStatePropertyAll(
                  StatusColors.statusColors[StatusManga.statusList.indexOf(e)])
              : MaterialStatePropertyAll(
                  Theme.of(context).scaffoldBackgroundColor,
                ),
          showCheckmark: false,
          onSelected: (bool value) {
            this.selectedStatus.value = e;
          },
        );
      }).toList();
    }
    return [];
  }

  @override
  void initState() {
    super.initState();

    /// Initialize [selectedStatus] with [MylistModel.userStatus] if not null, else initialize with default value.
    if (widget.mylistModel.userStatus != null) {
      selectedStatus = ValueNotifier(widget.mylistModel.userStatus!);
    } else {
      selectedStatus = ValueNotifier(
        widget.type == SearchType.anime
            ? StatusAnime.planToWatch
            : StatusManga.planToRead,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                Row(
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const CenterLoadingIndicator(),
                        );

                        if (widget.type == SearchType.anime) {
                          await MylistAnimeStore.saveMylist(
                            mylistModel: widget.mylistModel.copyWith(
                              userStatus: selectedStatus.value,
                              userScore: userScore,
                              userProgress: userProgress,
                              userStartDate: userStartDate,
                              userEndDate: userEndDate,
                            ),
                          );
                          context.read<MylistAnimeBloc>().add(
                                const MylistAnimeLoadEvent(),
                              );
                        } else if (widget.type == SearchType.manga) {
                          await MylistMangaStore.saveMylist(
                            mylistModel: widget.mylistModel.copyWith(
                              userStatus: selectedStatus.value,
                              userScore: userScore,
                              userProgress: userProgress,
                              userStartDate: userStartDate,
                              userEndDate: userEndDate,
                            ),
                          );
                          context.read<MylistMangaBloc>().add(
                                const MylistMangaLoadEvent(),
                              );
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
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Text(
                    widget.mylistModel.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Divider(),
                const BottomSheetStatusTitleRow(),
                ValueListenableBuilder(
                    valueListenable: selectedStatus,
                    builder: (context, selectedStatus, _) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6.0,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: statusList(
                            type: widget.type, selectedStatus: selectedStatus),
                      );
                    }),
                const Divider(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () async {
                    if (widget.type == SearchType.anime) {
                      await MylistAnimeStore.deleteMylist(
                        mylistModel: widget.mylistModel,
                      );
                      context.read<MylistAnimeBloc>().add(
                            const MylistAnimeLoadEvent(),
                          );
                    } else if (widget.type == SearchType.manga) {
                      await MylistMangaStore.deleteMylist(
                        mylistModel: widget.mylistModel,
                      );
                      context.read<MylistMangaBloc>().add(
                            const MylistMangaLoadEvent(),
                          );
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Delete from list',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Show [EditListBottomSheet] as a modal bottom sheet.
Future<void> showEditListBottomSheet(
    {required BuildContext context,
    required SearchType type,
    required MylistModel mylistModel}) async {
  await showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) =>
        EditListBottomSheet(type: type, mylistModel: mylistModel),
  );
}
