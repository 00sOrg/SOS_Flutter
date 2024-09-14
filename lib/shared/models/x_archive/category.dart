import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'category.freezed.dart';
part 'category.g.dart';

enum CategoryKey {
  WARN,
  FOOD,
  FUN,
  CUTE,
  ETC,
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

@freezed
class Category with _$Category {
  const factory Category({
    required String text,
    required String iconPath,
    required String iconPathColored,
    @ColorConverter() required Color color,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

const Map<CategoryKey, Category> categories = {
  CategoryKey.WARN: Category(
    text: '위험',
    iconPath: 'assets/icons/warn_icon.svg',
    iconPathColored: 'assets/icons/warn_icon_colored.svg',
    color: Color(0xFFFFC9C9),
  ),
  CategoryKey.FOOD: Category(
    text: '먹거리',
    iconPath: 'assets/icons/food_icon.svg',
    iconPathColored: 'assets/icons/food_icon_colored.svg',
    color: Color(0xFFDDFFC7),
  ),
  CategoryKey.FUN: Category(
    text: '볼거리',
    iconPath: 'assets/icons/fun_icon.svg',
    iconPathColored: 'assets/icons/fun_icon_colored.svg',
    color: Color(0xFFD7EEFF),
  ),
  CategoryKey.CUTE: Category(
    text: '귀여움',
    iconPath: 'assets/icons/cute_icon.svg',
    iconPathColored: 'assets/icons/cute_icon_colored.svg',
    color: Color(0xFFFFF5C2),
  ),
  CategoryKey.ETC: Category(
    text: '기타',
    iconPath: 'assets/icons/etc_icon.svg',
    iconPathColored: 'assets/icons/etc_icon_colored.svg',
    color: Color(0xFFEDEDED),
  ),
};

Category getCategory(CategoryKey key) {
  return categories[key] ?? categories[CategoryKey.ETC]!;
}