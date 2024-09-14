import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class FriendAddBtn extends StatelessWidget {
  const FriendAddBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          // height: 145.h,
          // width: 157.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFAFAFA),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 36,
              color: AppColors.lineGray,
            ),
          )),
    );
  }
}
