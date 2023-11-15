final class StatusAnime {
  StatusAnime._();

  static List<String> statusList = [
    StatusAnime.watching,
    StatusAnime.completed,
    StatusAnime.planToWatch,
    StatusAnime.onHold,
    StatusAnime.dropped,
  ];

  static const String watching = 'Watching';
  static const String completed = 'Completed';
  static const String planToWatch = 'Plan to Watch';
  static const String onHold = 'On-Hold';
  static const String dropped = 'Dropped';
}
