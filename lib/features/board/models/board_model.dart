import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
class BoardModel with _$BoardModel {
  const factory BoardModel({
    required int id,
    required String title,
    String? image,
    required String content,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) => _$BoardModelFromJson(json);
}