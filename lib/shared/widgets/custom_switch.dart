import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class CustomSwitch extends StatelessWidget {
  final bool isOn;
  final VoidCallback onTap;
  // final Color activeColor;
  // final Color inactiveColor;
  final Duration animationDuration;
  final double width;
  final double height;

  const CustomSwitch({
    required this.isOn,
    required this.onTap,
    // this.activeColor = AppColors.blue,
    // this.inactiveColor = AppColors.white,
    this.animationDuration = const Duration(milliseconds: 300),
    this.width = 46,
    this.height = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeIn,
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC7C7C7),
              Colors.white,
              Colors.white,
            ],
            stops: [0.001, 0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              duration: animationDuration,
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: animationDuration,
                curve: Curves.easeInOut,
                width: width / 2,
                height: height * 0.72,
                decoration: BoxDecoration(
                  color: isOn ? AppColors.blue : AppColors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2), // Head shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
