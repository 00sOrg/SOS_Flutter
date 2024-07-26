import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TargetButton extends StatelessWidget {
  const TargetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 2),
            blurRadius: 1.2,
            spreadRadius: 1.2,
          ),
        ],
        borderRadius: BorderRadius.circular(19),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/target.svg',
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}