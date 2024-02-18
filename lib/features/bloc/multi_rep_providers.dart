import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/info/anime_full.dart';
import '../../data/services/info/manga_full.dart';
import '../../data/services/recommends/recent_recommends_anime.dart';
import '../../data/services/recommends/recent_recommends_manga.dart';
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

class MultiRepProviders extends MultiRepositoryProvider {
  MultiRepProviders({super.key, required super.child})
      : super(providers: providers);

  static List<RepositoryProvider> providers = [
    /// Search
    RepositoryProvider<AnimeSearch>(
      create: (_) => AnimeSearch(),
    ),
    RepositoryProvider<MangaSearch>(
      create: (_) => MangaSearch(),
    ),
    RepositoryProvider<CharactersSearch>(
      create: (_) => CharactersSearch(),
    ),
    RepositoryProvider<PeopleSearch>(
      create: (_) => PeopleSearch(),
    ),

    /// Seasonal
    RepositoryProvider<SeasonNowService>(
      create: (_) => SeasonNowService(),
    ),
    RepositoryProvider<SeasonLastService>(
      create: (_) => SeasonLastService(),
    ),
    RepositoryProvider<SeasonArchiveService>(
      create: (_) => SeasonArchiveService(),
    ),
    RepositoryProvider<SeasonUpcomingService>(
      create: (_) => SeasonUpcomingService(),
    ),
    RepositoryProvider<SeasonsService>(
      create: (_) => SeasonsService(),
    ),

    /// Info
    RepositoryProvider<AnimeFullService>(
      create: (_) => AnimeFullService(),
    ),
    RepositoryProvider<MangaFullService>(
      create: (_) => MangaFullService(),
    ),

    /// Top Data
    RepositoryProvider<TopAnimeService>(
      create: (_) => TopAnimeService(),
    ),
    RepositoryProvider<TopMangaService>(
      create: (_) => TopMangaService(),
    ),
    RepositoryProvider<TopCharactersService>(
      create: (_) => TopCharactersService(),
    ),
    RepositoryProvider<TopPeopleService>(
      create: (_) => TopPeopleService(),
    ),

    /// Recent Reviews
    RepositoryProvider<RecentReviewsAnimeService>(
      create: (_) => RecentReviewsAnimeService(),
    ),
    RepositoryProvider<RecentReviewsMangaService>(
      create: (_) => RecentReviewsMangaService(),
    ),

    /// Recent Recommends
    RepositoryProvider<RecentRecommendsAnimeService>(
      create: (_) => RecentRecommendsAnimeService(),
    ),
    RepositoryProvider<RecentRecommendsMangaService>(
      create: (_) => RecentRecommendsMangaService(),
    ),
  ];
}
