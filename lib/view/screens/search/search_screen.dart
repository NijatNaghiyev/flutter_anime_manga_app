import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/custom_app_bar_bottom.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_error_view.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_history/search_history_view.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_initial.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_list/search_anime_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_list/search_characters_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_list/search_manga_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_list/search_people_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../widgets/center_loading_indicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchEditingController = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  bool isDialogOpen = false;

  /// Close dialog if open
  void closeDialog() {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
    searchFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: MyColors.primary,
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: CustomAppBarBottom(
            searchEditingController: searchEditingController,
            searchFormKey: searchFormKey,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<SearchBloc, SearchState>(
          buildWhen: (previous, current) {
            if (current is! SearchStateAction &&
                previous.props != current.props) {
              return true;
            }
            return false;
          },
          listenWhen: (previous, current) {
            if (current is SearchStateAction &&
                previous.props != current.props) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is SearchLoadingState) {
              isDialogOpen = true;
              showGeneralDialog(
                barrierDismissible: false,
                useRootNavigator: false,
                barrierLabel: 'Search Loading',
                barrierColor: Colors.transparent,
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CenterLoadingIndicator(),
              );
            }
          },
          builder: (context, state) {
            log(state.toString());

            log('build');

            /// Initial
            if (state is SearchInitial) {
              log('init');

              return const SearchInitialView();
            }

            if (state is SearchHistoryState) {
              log('history');

              return SearchHistoryView(
                searchEditingController: searchEditingController,
              );
            }

            /// Loaded Anime SEARCH
            if (state is SearchLoadedAnimeState) {
              log('loaded anime');

              //  Close dialog if open
              closeDialog();

              return SearchAnimeList(state: state);
            }

            /// Loaded Manga SEARCH
            if (state is SearchLoadedMangaState) {
              log('loaded manga');

              // Close dialog if open
              closeDialog();

              return SearchMangaList(state: state);
            }

            /// Loaded Characters SEARCH
            if (state is SearchLoadedCharactersState) {
              log('loaded characters');

              // Close dialog if open
              closeDialog();

              return SearchCharactersList(state: state);
            }

            /// Loaded People SEARCH
            if (state is SearchLoadedPeopleState) {
              log('loaded People');

              // Close dialog if open
              closeDialog();

              return SearchPeopleList(state: state);
            }

            /// Error
            if (state is SearchErrorState) {
              log('error state');

              // Close dialog if open
              closeDialog();

              return SearchErrorView(state: state);
            }

            /// Default
            log('Default');
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
