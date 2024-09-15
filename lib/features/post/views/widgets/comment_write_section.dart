import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class CommentWriteSection extends StatelessWidget {
  const CommentWriteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Use Expanded to let the container grow with its content
      child: Container(
        color: AppColors.lineGray,
        padding: const EdgeInsets.fromLTRB(16, 11, 13, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
              ),
            ),
            const SizedBox(
                width: 10), // Add space between the text field and the button
            Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: AppColors.blue, // Replace with your desired color
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  // TODO: 댓글 전송 로직 구현
                  debugPrint('Send comment');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
