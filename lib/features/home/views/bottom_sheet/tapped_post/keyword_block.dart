import 'package:flutter/material.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeywordBlock extends StatelessWidget {
  final String keyword;
  final String? mediaUrl;

  const KeywordBlock({
    super.key,
    required this.keyword,
    this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162.w,
      height: 28.h,
      decoration: ShapeDecoration(
        color: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: (mediaUrl != null &&
                  mediaUrl!.isNotEmpty) // mediaUrl이 null이 아니고 비어있지 않으면
              ? const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )
              : BorderRadius.circular(50), // mediaUrl이 없으면 전체에 radius 적용
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
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
  final String? mediaUrl;

  const EventTypeBlock({
    super.key,
    required this.eventType,
    this.mediaUrl,
  });

  @override
  Widget build(BuildContext context) {
    final postType = getPostTypeFromString(eventType);
    return Container(
      width: 162.w,
      height: 28.h,
      decoration: ShapeDecoration(
        color: AppColors.blue,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.blue),
          borderRadius: (mediaUrl != null &&
                  mediaUrl!.isNotEmpty) // mediaUrl이 있으면 왼쪽만 radius 적용
              ? const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )
              : BorderRadius.circular(50), // mediaUrl이 없으면 전체에 radius 적용
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          postType.koreanName,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
