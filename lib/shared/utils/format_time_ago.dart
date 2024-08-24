String formatTimeAgo(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);

  if (duration.inMinutes < 1) {
    return '방금 전';
  } else if (duration.inMinutes < 60) {
    return '${duration.inMinutes}분 전';
  } else if (duration.inHours < 24) {
    return '${duration.inHours}시간 전';
  } else if (duration.inDays < 7) {
    return '${duration.inDays}일 전';
  } else if (duration.inDays < 30) {
    return '${(duration.inDays / 7).floor()}주 전';
  } else if (duration.inDays < 365) {
    return '${(duration.inDays / 30).floor()}개월 전';
  } else {
    return '${(duration.inDays / 365).floor()}년 전';
  }
}
