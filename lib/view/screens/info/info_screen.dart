import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/info/info_bloc/info_bloc.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_initial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/center_loading_indicator.dart';
import 'widgets/info_anime_loaded_page.dart';
import 'widgets/info_manga_loaded_page.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
    required this.malId,
    required this.type,
  });

  final int malId;
  final SearchType type;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool isDialogOpen = false;

  /// Close dialog if open
  void closeDialog() {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.of(context).pop();
    }
  }

  void initInfo() {
    if (widget.type == SearchType.anime) {
      context.read<InfoBloc>().add(
            InfoAnimeEvent(malId: widget.malId),
          );
    } else if (widget.type == SearchType.manga) {
      context.read<InfoBloc>().add(
            InfoMangaEvent(malId: widget.malId),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InfoBloc, InfoState>(
        // buildWhen: (previous, current) => current is! InfoStateAction,
        // listenWhen: (previous, current) => current is InfoStateAction,
        listener: (context, state) {
          if (state is InfoLoadingState) {
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

          if (state is! InfoLoadingState) {
            closeDialog();
          }
        },
        builder: (context, state) {
          /// Anime Loaded
          if (state is InfoAnimeLoadedState) {
            return InfoAnimeLoadedPage(
              animeFullModel: state.animeFull,
              imagesList: state.imagesList,
              animeStaff: state.animeStaff,
              themesModel: state.themesModel,
              musicVideos: state.musicVideos,
              reviews: state.reviews,
            );
          }

          /// Manga Loaded
          if (state is InfoMangaLoadedState) {
            return InfoMangaLoadedPage(
              mangaFullModel: state.mangaFull,
              imagesList: state.imagesList,
            );
          }

          /// Error
          if (state is InfoErrorState) {
            return Center(
              child: ErrorRetry(
                state: state,
                onRetry: initInfo,
              ),
            );
          }

          /// Default
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
