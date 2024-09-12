import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          'assets/icons/logo_lean.png',
          width: 181.w,
        ),
        // SvgPicture.asset(
        //   'assets/icons/logo.svg', 
        //   width: 181.w,
        // ),
      ),
    );
  }
}
