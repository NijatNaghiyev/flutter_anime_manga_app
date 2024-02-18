import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enum/parameter_search_type.dart';
import '../../data/services/info/anime_full.dart';
import '../../data/services/info/manga_full.dart';
import '../../data/services/reviews/recent_reviews_anime.dart';
import '../../data/services/reviews/recent_reviews_manga.dart';
import '../../data/services/search/anime_search.dart';
import '../../data/services/search/characters_search.dart';
import '../../data/services/search/manga_search.dart';
import '../../data/services/search/people_search.dart';
import '../../data/services/seasonal/season_any.dart';
import '../../data/services/seasonal/season_last.dart';
import '../../data/services/seasonal/season_now.dart';
import '../../data/services/seasonal/season_upcoming.dart';
import '../../data/services/seasonal/seasons.dart';
import '../../data/services/top_data/top_anime_service.dart';
import '../../data/services/top_data/top_characters_service.dart';
import '../../data/services/top_data/top_manga_service.dart';
import '../../data/services/top_data/top_people_service.dart';
import '../state/bloc/home/home_screen/home_bloc.dart';
import '../state/bloc/info/info_bloc/info_bloc.dart';
import '../state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import '../state/bloc/search-screen/search/data_search_bloc.dart';
import '../state/bloc/search-screen/top_data/top_characters/top_characters_bloc.dart';
import '../state/bloc/search-screen/top_data/top_data_anime/top_data_anime_bloc.dart';
import '../state/bloc/search-screen/top_data/top_manga/top_manga_bloc.dart';
import '../state/bloc/search-screen/top_data/top_people/top_people_bloc.dart';
import '../state/bloc/seasonal/season_archive/season_archive_bloc.dart';
import '../state/bloc/seasonal/season_last/season_last_bloc.dart';
import '../state/bloc/seasonal/season_now/season_now_bloc.dart';
import '../state/bloc/seasonal/season_upcoming/season_upcoming_bloc.dart';
import '../state/cubit/core/bottom_nav_bar_cubit.dart';
import '../state/cubit/drawer/drawer_image_cubit.dart';
import '../state/cubit/search_lists/search_lists_cubit.dart';

class MultiProviders extends MultiBlocProvider {
  MultiProviders({super.key, required super.child})
      : super(providers: providers);

  static List<BlocProvider> providers = [
    /// Search
    BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        animeSearch: context.read<AnimeSearch>(),
        mangaSearch: context.read<MangaSearch>(),
        charactersSearch: context.read<CharactersSearch>(),
        peopleSearch: context.read<PeopleSearch>(),
      )..add(
          SearchInitialEvent(),
        ),
    ),

    /// Info
    BlocProvider<InfoBloc>(
      create: (context) => InfoBloc(
        animeFullService: context.read<AnimeFullService>(),
        mangaFullService: context.read<MangaFullService>(),
      ),
    ),

    /// Home
    BlocProvider<HomeBloc>(
      lazy: false,
      create: (context) => HomeBloc(
        recentReviewsAnimeService: context.read<RecentReviewsAnimeService>(),
        recentReviewsMangaService: context.read<RecentReviewsMangaService>(),
      )..add(
          HomeEventInitial(),
        ),
    ),

    /// Seasonal
    BlocProvider<SeasonNowBloc>(
      lazy: false,
      create: (context) => SeasonNowBloc(
        seasonNowService: context.read<SeasonNowService>(),
      )..add(
          const SeasonNowInitialEvent(type: ParameterSearchTypeAnime.Default),
        ),
    ),
    BlocProvider<SeasonLastBloc>(
      create: (context) => SeasonLastBloc(
        seasonLastService: context.read<SeasonLastService>(),
      )..add(
          const SeasonLastInitialEvent(type: ParameterSearchTypeAnime.Default),
        ),
    ),
    BlocProvider<SeasonUpcomingBloc>(
      create: (context) => SeasonUpcomingBloc(
        seasonUpcomingService: context.read<SeasonUpcomingService>(),
      )..add(
          const SeasonUpcomingInitialEvent(
              type: ParameterSearchTypeAnime.Default),
        ),
    ),
    BlocProvider<SeasonArchiveBloc>(
      create: (context) => SeasonArchiveBloc(
        seasonArchiveService: context.read<SeasonArchiveService>(),
        seasonsService: context.read<SeasonsService>(),
      )..add(
          const SeasonArchiveInitPageEvent(),
        ),
    ),

    /// Mylist
    BlocProvider<MylistAnimeBloc>(
      lazy: false,
      create: (_) => MylistAnimeBloc()
        ..add(
          const MylistAnimeLoadEvent(),
        ),
    ),
    BlocProvider<MylistMangaBloc>(
      create: (_) => MylistMangaBloc()
        ..add(
          const MylistMangaLoadEvent(),
        ),
    ),

    /// Top Data
    BlocProvider<TopDataAnimeBloc>(
      lazy: false,
      create: (context) => TopDataAnimeBloc(
        topAnime: context.read<TopAnimeService>(),
      )..add(
          const TopDataAnimeLoadEvent(),
        ),
    ),
    BlocProvider<TopMangaBloc>(
      create: (context) => TopMangaBloc(
        context.read<TopMangaService>(),
      )..add(
          const TopMangaLoadEvent(),
        ),
    ),
    BlocProvider<TopPeopleBloc>(
      create: (context) => TopPeopleBloc(
        context.read<TopPeopleService>(),
      )..add(
          const TopPeopleLoadEvent(),
        ),
    ),
    BlocProvider<TopCharactersBloc>(
      create: (context) => TopCharactersBloc(
        context.read<TopCharactersService>(),
      )..add(
          const TopCharactersLoadEvent(),
        ),
    ),

    /// Cubit
    BlocProvider<SearchListsCubit>(
      create: (context) => SearchListsCubit(),
    ),
    BlocProvider<BottomNavBarCubit>(
      create: (context) => BottomNavBarCubit(),
    ),
    BlocProvider<DrawerImageCubit>(
      lazy: false,
      create: (context) {
        return DrawerImageCubit()..profilePhotoUrl();
      },
    ),
  ];
}
