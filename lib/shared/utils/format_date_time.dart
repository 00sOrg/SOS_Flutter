String formatDateTime(DateTime dateTime) {
  final year = dateTime.year;
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');

  final date = '$year.$month.$day';
  final time = '$hour:$minute';

  return '$date | $time';
}