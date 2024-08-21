import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingModal extends StatelessWidget {
  final String title;
  final String content;
  final String leftBtn;
  final String rightBtn;
  final VoidCallback onRightBtnPressed;

  const SettingModal({
    required this.title,
    required this.content,
    required this.leftBtn,
    required this.rightBtn,
    required this.onRightBtnPressed,
    super.key,
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
            padding: const EdgeInsets.all(20),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            leftBtn,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: AppColors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: onRightBtnPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(0),
                //   topRight: Radius.circular(0),
                //   bottomRight: Radius.circular(0),
                //   bottomLeft: Radius.circular(20),
                // ),
                borderRadius: BorderRadius.zero),
          ),
          child: Text(
            rightBtn,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
