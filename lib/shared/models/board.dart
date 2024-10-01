import 'package:freezed_annotation/freezed_annotation.dart';

part 'board.freezed.dart';
part 'board.g.dart';

@freezed
class Board with _$Board {
  const factory Board({
    int? eventId,
    int? id,
    String? eventLevel,
    String? eventType,
    required String title,
    String? content,
    String? media,
    List<String>? keywords,
  }) = _Board;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}
