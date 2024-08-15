String formatDateTime(DateTime dateTime) {
  final year = dateTime.year;
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');

  final date = '$year-$month-$day';
  final time = '$hour:$minute';

  return '$date $time';
}

// 테스트
// void main() {
//   // Example timestamp (milliseconds since Unix epoch)
//   int timestamp = 1691573100000; // Corresponds to 2024-08-09 13:45:00 UTC

//   // Convert timestamp to DateTime
//   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

//   // Format the DateTime
//   String formattedDateTime = formatDateTime(dateTime);

//   print(formattedDateTime); // Output: "2024년 08월 09일 13:45"
// }
