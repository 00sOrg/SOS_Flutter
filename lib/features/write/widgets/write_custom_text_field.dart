import 'package:flutter/material.dart';
import 'package:nearhere/shared/styles/border_styles.dart';

class WriteCustomTextField extends StatelessWidget {
  final bool isOneLine;
  final ValueChanged<String> onChanged;

  const WriteCustomTextField({super.key, required this.isOneLine, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isOneLine ? 48 : null,
      child: TextField(
        keyboardType: isOneLine ? TextInputType.text : TextInputType.multiline,
        autocorrect: false,
        maxLines: isOneLine ? 1 : 5,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: BorderStyles.defaultBorder,
          enabledBorder: BorderStyles.defaultBorder,
          focusedBorder: BorderStyles.defaultBorder,
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF343434),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
