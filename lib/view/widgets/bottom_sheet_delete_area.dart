import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enum/search_type.dart';
import '../../data/services/firestore_database/mylist_anime_store.dart';
import '../../data/services/firestore_database/mylist_manga_store.dart';
import '../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import 'center_loading_indicator.dart';
import 'edit_list_bottom_sheet.dart';

class BottomSheerDeleteArea extends StatelessWidget {
  const BottomSheerDeleteArea({
    super.key,
    required this.widget,
  });

  final EditListBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[800],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () async {
                showGeneralDialog(
                  barrierDismissible: false,
                  useRootNavigator: false,
                  barrierLabel: 'Delete Loading',
                  barrierColor: Colors.transparent,
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CenterLoadingIndicator(),
                );

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

                /// For Dialog
                Navigator.pop(context);

                /// For BottomSheet
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
    );
  }
}
