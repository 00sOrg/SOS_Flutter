import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendHelpBtn extends StatelessWidget {
  final String image;
  final String text;

  const FriendHelpBtn({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/logo.svg', height: 50),
            const SizedBox(height: 6),
            Text(
              '$text 주변 도움 요청',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
