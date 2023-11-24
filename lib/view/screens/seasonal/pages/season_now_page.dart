import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_initial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/state/bloc/seasonal/season_now/season_now_bloc.dart';
import '../../../../constants/enum/parameter_search_type.dart';
import '../../../widgets/center_loading_indicator.dart';
import '../widgets/seasonal_grid_view.dart';

class SeasonNowPage extends StatefulWidget {
  const SeasonNowPage({super.key});

  @override
  State<SeasonNowPage> createState() => _SeasonNowPageState();
}

class _SeasonNowPageState extends State<SeasonNowPage> {
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
    return BlocConsumer<SeasonNowBloc, SeasonNowState>(
      buildWhen: (previous, current) => current is! SeasonNowAction,
      listenWhen: (previous, current) => current is SeasonNowAction,
      listener: (context, state) {
        if (state is SeasonNowLoading) {
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
        if (state is SeasonNowLoaded) {
          closeDialog();

          return SeasonalGridView(
            blocType: 'season_now',
            data: state.seasonalData,
            animeList: state.animeList,
          );
        }

        /// Error
        if (state is SeasonNowError) {
          closeDialog();
          return Center(
            child: ErrorRetry(
              state: state,
              onRetry: () {
                context.read<SeasonNowBloc>().add(
                      const SeasonNowInitialEvent(
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
