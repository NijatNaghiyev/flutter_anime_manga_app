import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enum/parameter_search_type.dart';
import '../../../../features/state/bloc/seasonal/season_last/season_last_bloc.dart';
import '../../../widgets/center_loading_indicator.dart';
import '../../search/widgets/search_initial.dart';
import '../widgets/seasonal_grid_view.dart';

class SeasonLastPage extends StatefulWidget {
  const SeasonLastPage({super.key});

  @override
  State<SeasonLastPage> createState() => _SeasonLastPageState();
}

class _SeasonLastPageState extends State<SeasonLastPage> {
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
    return BlocConsumer<SeasonLastBloc, SeasonLastState>(
      buildWhen: (previous, current) => current is! SeasonLastAction,
      listenWhen: (previous, current) => current is SeasonLastAction,
      listener: (context, state) {
        if (state is SeasonLastLoading) {
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
        /// Loaded
        if (state is SeasonLastLoaded) {
          closeDialog();

          return SeasonalGridView(
            blocType: 'season_last',
            data: state.seasonalData,
            animeList: state.animeList,
          );
        }

        /// Error
        if (state is SeasonLastError) {
          closeDialog();
          return Center(
            child: ErrorRetry(
              state: state,
              onRetry: () {
                context.read<SeasonLastBloc>().add(
                      const SeasonLastInitialEvent(
                        type: ParameterSearchTypeAnime.Default,
                      ),
                    );
              },
            ),
          );
        }

        /// Default
        return const SizedBox.shrink();
      },
    );
  }
}
