import 'package:flutter/material.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeywordBlock extends StatelessWidget {
  final String keyword;

  const KeywordBlock({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162.w,
      height: 28.h,
      decoration: ShapeDecoration(
        color: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            keyword,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class EventTypeBlock extends StatelessWidget {
  final String eventType;

  const EventTypeBlock({super.key, required this.eventType});

  @override
  Widget build(BuildContext context) {
    final postType = getPostTypeFromString(eventType);
    return Container(
      width: 162.w,
      height: 28.h,
      decoration: ShapeDecoration(
        color: AppColors.blue,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.blue),
          borderRadius: BorderRadius.circular(50),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: Text(
          postType.koreanName,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
