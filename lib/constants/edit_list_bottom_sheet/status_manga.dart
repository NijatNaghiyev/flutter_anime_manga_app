final class StatusManga {
  StatusManga._();

  static List<String> statusList = [
    StatusManga.reading,
    StatusManga.completed,
    StatusManga.planToRead,
    StatusManga.onHold,
    StatusManga.dropped,
  ];

  static const String reading = 'Reading';
  static const String completed = 'Completed';
  static const String planToRead = 'Plan to Read';
  static const String onHold = 'On-Hold';
  static const String dropped = 'Dropped';
}
