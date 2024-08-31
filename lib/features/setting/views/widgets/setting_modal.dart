import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingModal extends StatelessWidget {
  final String title;
  final String content;
  final String leftBtn;
  final String rightBtn;
  final VoidCallback onRightBtnPressed;
  final Color? rightBtnColor;

  const SettingModal({
    required this.title,
    required this.content,
    required this.leftBtn,
    required this.rightBtn,
    required this.onRightBtnPressed,
    super.key,
    this.rightBtnColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 17, height: 1.3),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 13,
          height: 1.4,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            leftBtn,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: onRightBtnPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            rightBtn,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: rightBtnColor ?? AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
