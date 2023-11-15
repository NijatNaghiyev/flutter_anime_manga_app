import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_archive_init_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/state/bloc/seasonal/season_archive/season_archive_bloc.dart';
import '../../../widgets/center_loading_indicator.dart';
import '../widgets/seasonal_grid_view.dart';

ValueNotifier<int?> yearArchive = ValueNotifier(null);
ValueNotifier<String?> seasonArchive = ValueNotifier(null);

class SeasonArchivePage extends StatefulWidget {
  const SeasonArchivePage({super.key});

  @override
  State<SeasonArchivePage> createState() => _SeasonArchivePageState();
}

class _SeasonArchivePageState extends State<SeasonArchivePage> {
  bool isDialogOpen = false;

  /// Close dialog if open
  void closeDialog() {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeasonArchiveBloc, SeasonArchiveState>(
      buildWhen: (previous, current) => current is! SeasonArchiveAction,
      listenWhen: (previous, current) => current is SeasonArchiveAction,
      listener: (context, state) {
        if (state is SeasonArchiveLoading) {
          isDialogOpen = true;
          showGeneralDialog(
            barrierDismissible: false,
            useRootNavigator: false,
            barrierColor: Colors.transparent,
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CenterLoadingIndicator(),
          );
        }
      },
      builder: (context, state) {
        /// Initial
        if (state is SeasonArchiveInitPageState) {
          closeDialog();

          return SeasonArchiveInitView(
            data: state.seasonsData,
          );
        }

        /// Loading
        if (state is SeasonArchiveLoaded) {
          closeDialog();

          return SeasonalGridView(
            blocType: 'season_archive',
            data: state.seasonalData,
            animeList: state.animeList,
          );
        }

        /// Error
        if (state is SeasonArchiveError) {
          closeDialog();
          return const Center(
            child: Text('Error'),
          );
        }

        /// Default
        return const SizedBox.shrink();
      },
    );
  }
}
