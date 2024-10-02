import 'package:flutter/material.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/styles/global_styles.dart';

// enum PostType {
//   fire,
//   typhoon,
//   earthquake,
//   war,
//   flood,
//   accident,
//   carAccident,
//   other,
// }

class EmergencyResponse extends StatelessWidget {
  final PostType eventType;

  const EmergencyResponse({Key? key, required this.eventType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 14),
            _buildContent(),
            SizedBox(height: 20),
            _buildCloseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Stack을 사용하여 CircleAvatar 내부에 아이콘과 텍스트 겹치기
        const Stack(
          alignment: Alignment.center, // Stack 내에서 중앙 정렬
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.orange, // 원의 배경 색상
              // child: Icon(Icons.warning, color: Colors.white), // 기본 경고 아이콘
            ),
            Positioned(
              bottom: 2,
              child: SizedBox(
                width: 11, // 텍스트의 너비 설정
                height: 26, // 텍스트의 높이 설정
                child: Text(
                  '!', // 느낌표 텍스트 추가
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상
                    fontSize: 24, // 텍스트 크기
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Apple SD Gothic Neo',
                    height: 1, // 텍스트의 줄 간격 조정
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 13), // 아이콘과 텍스트 사이의 간격
        Expanded(
          child: Text(
            _getTitleByEventType(), // 이벤트 타입에 맞는 제목을 가져옴
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Apple SD Gothic Neo',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  // 이벤트 타입에 따라 타이틀을 반환하는 함수
  String _getTitleByEventType() {
    switch (eventType) {
      case PostType.fire:
        return '화재 시 행동요령';
      case PostType.earthquake:
        return '지진 시 행동요령';
      case PostType.flood:
        return '홍수 시 행동요령';
      case PostType.typhoon:
        return '태풍 시 행동요령';
      case PostType.war:
        return '전쟁 시 대처 방법';
      case PostType.accident:
        return '사고 시 행동요령';
      case PostType.carAccident:
        return '교통사고 시 행동요령';
      default:
        return '긴급 상황 시 대처 방법';
    }
  }

  Widget _buildContent() {
    switch (eventType) {
      case PostType.fire:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/fire.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "화재를 발견했을 때", "즉시 119에 신고하고 주변 사람들에게 알립니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "대피 준비", "불길에서 멀리 떨어져 안전한 장소로 대피합니다."),
          ],
        );
      case PostType.earthquake:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/earthquake.png'),
            const SizedBox(height: 14),
            _buildInstruction(
                1, "지진을 감지했을 때", "탁자 아래로 들어가 몸을 보호하고, 떨어지는 물건을 조심합니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "대피 준비", "떨어지는 물건이 없는 곳으로 대피하며, 최대한 몸을 낮춥니다."),
          ],
        );
      case PostType.flood:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/flood.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "홍수를 감지했을 때", "높은 곳으로 대피하고 물이 빠질 때까지 기다립니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "대피 준비", "필요한 물품을 챙겨 안전한 장소로 대피합니다."),
          ],
        );
      case PostType.typhoon:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/typhoon.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "태풍 접근 시", "바람에 날아갈 수 있는 물건을 고정하고 외출을 자제합니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "태풍 진행 중", "실내에서 안전하게 머물며 창문을 단단히 닫습니다."),
          ],
        );
      case PostType.war:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/war.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "전쟁 발생 시", "안전한 대피소로 이동하고, 공습 경보에 주의합니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "대피 준비", "필수 물품을 준비하고 정부 지침을 따릅니다."),
          ],
        );
      case PostType.accident:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/accident.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "사고를 발견했을 때", "신속하게 도움을 요청하고, 안전을 확인합니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "구조 대기", "응급 구조대가 도착할 때까지 부상자를 안정시킵니다."),
          ],
        );
      case PostType.carAccident:
        return Column(
          children: <Widget>[
            _buildImage(
                'assets/icons/post/emergency_response/car_accident.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "교통사고 발생 시", "비상등을 켜고 즉시 119와 경찰에 신고합니다."),
            const SizedBox(height: 14),
            _buildInstruction(
                2, "사고 처리", "부상자가 있으면 응급조치를 시행하고, 현장을 안전하게 보호합니다."),
          ],
        );
      default:
        return Column(
          children: <Widget>[
            _buildImage('assets/icons/post/emergency_response/emergency.png'),
            const SizedBox(height: 14),
            _buildInstruction(1, "긴급 상황 발생", "상황에 맞게 대처하고 빠르게 대응합니다."),
            const SizedBox(height: 14),
            _buildInstruction(2, "긴급신고전화", "112·119·110만 기억하면 됩니다."),
          ],
        );
    }
  }

  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildInstruction(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number inside circle using Stack
          Stack(
            alignment: Alignment.center, // 숫자를 원의 중앙에 배치
            children: [
              Container(
                width: 21, // 원의 너비
                height: 21, // 원의 높이
                decoration: const BoxDecoration(
                  color: Color(0xFF6398E9),
                  shape: BoxShape.circle, // 원형으로 설정
                ),
              ),
              Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // 글자 크기
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Apple SD Gothic Neo',
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8), // 원과 텍스트 사이의 간격
          // Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 4), // 제목과 설명 사이의 간격
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('닫기', style: TextStyle(color: Colors.blue)),
    );
  }
}
