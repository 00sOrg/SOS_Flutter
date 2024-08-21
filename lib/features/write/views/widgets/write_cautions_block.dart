import 'package:flutter/material.dart';

class WriteCautionsBlock extends StatelessWidget {
  const WriteCautionsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '※ 주의사항 ※',
            style: TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 12,
              height: 1.2,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '''욕설 및 비방하는 글은 제한될 수 있습니다. 다른 사용자에 대한 존중과 예의를 지켜야 합니다. 공격적이거나 무례한 표현은 삼가세요.
다른 사용자의 의견을 존중하고, 예의 바르게 작성해주세요. 공격적이거나 무례한 언행은 피해야 합니다.
부적절한 주제는 삭제되거나 경고를 받을 수 있습니다.
복용한 영양제의 이름, 성분, 복용량, 복용 기간 등을 최대한 정확히 기재해주세요. 잘못된 정보는 다른 사용자에게 혼란을 줄 수 있습니다.
의사가 아닌 이상, 의학적 조언을 제공하지 않도록 주의하세요. 특정 건강 문제에 대한 진단이나 치료법을 제시하는 것은 위험할 수 있습니다.''',
            style: TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 12,
              height: 1.2,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
