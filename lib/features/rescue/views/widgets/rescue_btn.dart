import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';

class RescueBtn extends StatelessWidget {
  final double radius;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const RescueBtn({
    super.key,
    required this.radius,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedScaleDown(
      onTap: onTap,
      scaleValue: 0.974,
      child: Container(
        width: double.infinity,
        height: 106,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color], // 그라데이션 효과
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              color: Colors.grey.withOpacity(0.4), // 입체감을 위한 그림자
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            // 내부에 버튼 효과를 주는 장식
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2), // 버튼에 윤곽선 효과 추가
                    width: 2,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RescueBtn extends StatelessWidget {
//   final String text;
//   final Color color;
//   final VoidCallback onTap;

//   const RescueBtn({
//     super.key,
//     required this.text,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 108,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: color,
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(3, 3),
//               color: AppColors.black.withOpacity(0.25),
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 24,
//             height: 1.2,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFFFFFFFF),
//           ),
//         ),
//       ),
//     );
//   }
// }
