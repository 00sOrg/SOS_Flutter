import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class PostEventType extends StatelessWidget {
  final Post post;

  const PostEventType({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final eventColor = getTagColor(post.disasterType!); // 이벤트 타입에 따른 색상

    return Stack(
      children: [
        ClipPath(
          clipper: ConcaveArchClipper(), // 아치 모양 클리퍼
          child: Container(
            height: 60, // 높이를 조정하여 아치의 크기 결정
            width: double.infinity,
            color: eventColor, // 이벤트 색상
          ),
        ),
      ],
    );
  }
}

// 오목한 아치 모양을 위한 클리퍼 (양 끝만 크게 휘고 중앙은 평평한)
class ConcaveArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // 왼쪽 아래로부터 시작
    path.lineTo(0, size.height - 30);

    // 중앙에서 좀 더 평평한 곡선을 그리도록 y 값을 조정
    path.quadraticBezierTo(
      size.width * 0.01, // 왼쪽 끝에서 25% 위치
      size.height - 50, // Y값을 더 평평하게 유지
      size.width * 0.5, // 가운데
      size.height - 50, // 가운데도 Y값을 유지해 평평하게
    );

    // 오른쪽 50% 이후부터는 더 확실히 휘어지게 함
    path.quadraticBezierTo(
      size.width * 0.99, // 오른쪽 75% 지점
      size.height - 50, // 중앙과 동일한 높이
      size.width, // 오른쪽 끝
      size.height - 30, // 원래 높이로 돌아옴 (확 휘어짐)
    );

    // 오른쪽 상단으로 이어짐
    path.lineTo(size.width, 0);
    path.close(); // 경로 닫기

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
