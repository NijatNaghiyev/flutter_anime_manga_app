import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../../data/services/firestore_database/mylist_manga_store.dart';
import '../../../../../data/services/info/news_anime.dart';
import '../../../../../data/services/info/news_manga.dart';
import '../../../../../data/services/reviews/recent_reviews_anime.dart';
import '../../../../../data/services/reviews/recent_reviews_manga.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecentReviewsAnimeService recentReviewsAnimeService;
  final RecentReviewsMangaService recentReviewsMangaService;

  HomeBloc({
    required this.recentReviewsAnimeService,
    required this.recentReviewsMangaService,
  }) : super(HomeInitial()) {
    on<HomeEventInitial>(homeEventInitial);
  }

  Future<FutureOr<void>> homeEventInitial(
      HomeEventInitial event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    /// Recent Reviews Anime
    final reviewsAnimeList =
        await recentReviewsAnimeService.getReviewsAnimeList();
    if (reviewsAnimeList.isEmpty) {
      emit(const HomeErrorState(message: "Error RecentReviews Anime"));
    }
    await Future.delayed(const Duration(milliseconds: 500));

    /// Recent Reviews Manga
    final reviewsMangaList =
        await recentReviewsMangaService.getReviewsMangaList();
    if (reviewsMangaList.isEmpty) {
      emit(const HomeErrorState(message: "Error RecentReviews Manga"));
    }
    await Future.delayed(const Duration(milliseconds: 500));

    /// News Anime
    final mylistAnime = await MylistAnimeStore.getMylist();
    var animeNews = [];
    mylistAnime.shuffle();

    if (mylistAnime.isEmpty) {
      animeNews = [];
    } else {
      final animeMalIdFirst = mylistAnime.first.malId;
      final animeMalIdLast = mylistAnime.last.malId;
      animeNews = [
        ...await NewsAnimeService.getNews(malId: animeMalIdFirst),
        ...await NewsAnimeService.getNews(malId: animeMalIdLast),
      ];
    }

    await Future.delayed(const Duration(milliseconds: 500));

    /// News Manga
    final mylistManga = await MylistMangaStore.getMylist();
    var mangaNews = [];
    mylistManga.shuffle();
    if (mylistManga.isEmpty) {
      mangaNews = [];
    } else {
      final mangaMalId = mylistManga.first.malId;
      mangaNews = await NewsMangaService.getNews(malId: mangaMalId);
    }

    final List<dynamic> allList = [
      ...reviewsAnimeList,
      ...reviewsMangaList,
      ...animeNews,
      ...mangaNews,
    ];

    allList.sort((a, b) => b.date.compareTo(a.date));

    allList.shuffle();

    emit(HomeLoadedState(allList: allList));

    if (allList.isEmpty) {
      emit(const HomeErrorState(message: "Error Empty List"));
    }
  }
}
