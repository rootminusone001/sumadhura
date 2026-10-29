class TimeStampFormats {
  static String formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'Not available';
    }

    final dateTime = DateTime.tryParse(timestamp);

    if (dateTime == null) {
      return timestamp;
    }

    final localTime = dateTime.toLocal();

    final date =
        '${localTime.day.toString().padLeft(2, '0')}/'
        '${localTime.month.toString().padLeft(2, '0')}/'
        '${localTime.year}';

    final time =
        '${localTime.hour.toString().padLeft(2, '0')}:'
        '${localTime.minute.toString().padLeft(2, '0')}:'
        '${localTime.second.toString().padLeft(2, '0')}';

    return '$date, $time';
  }

  static bool isToday(String? timestamp, DateTime today) {
    if (timestamp == null || timestamp.isEmpty) {
      return false;
    }

    try {
      final date = DateTime.parse(timestamp).toLocal();

      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    } catch (_) {
      return false;
    }
  }

  static String formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Not yet available';
    }

    try {
      final parsedDate = DateTime.parse(date).toLocal();

      final day = parsedDate.day.toString().padLeft(2, '0');
      final month = parsedDate.month.toString().padLeft(2, '0');
      final year = parsedDate.year;

      final hour = parsedDate.hour.toString().padLeft(2, '0');
      final minute = parsedDate.minute.toString().padLeft(2, '0');

      return '$day/$month/$year, $hour:$minute';
    } catch (_) {
      return date;
    }
  }
}
