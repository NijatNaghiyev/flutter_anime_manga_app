import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/state/bloc/seasonal/season_upcoming/season_upcoming_bloc.dart';
import '../../../widgets/center_loading_indicator.dart';
import '../widgets/seasonal_grid_view.dart';

class SeasonUpcomingPage extends StatefulWidget {
  const SeasonUpcomingPage({super.key});

  @override
  State<SeasonUpcomingPage> createState() => _SeasonUpcomingPageState();
}

class _SeasonUpcomingPageState extends State<SeasonUpcomingPage> {
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
    return BlocConsumer<SeasonUpcomingBloc, SeasonUpcomingState>(
      buildWhen: (previous, current) => current is! SeasonUpcomingAction,
      listenWhen: (previous, current) => current is SeasonUpcomingAction,
      listener: (context, state) {
        if (state is SeasonUpcomingLoading) {
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
        /// Loading
        if (state is SeasonUpcomingLoaded) {
          closeDialog();

          return SeasonalGridView(
            blocType: 'season_upcoming',
            data: state.seasonalData,
            animeList: state.animeList,
          );
        }

        /// Error
        if (state is SeasonUpcomingError) {
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
