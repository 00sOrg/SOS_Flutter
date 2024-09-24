// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sos/shared/models/board.dart';
// import 'package:sos/shared/styles/global_styles.dart';

// class BoardItem extends StatelessWidget {
//   final Board post;

//   const BoardItem({super.key, required this.post});

//   Color _getRandomColor() {
//     final random = Random();
//     final prob = random.nextDouble();

//     if (prob < 0.5) {
//       return const Color(0xFFD5E0F0);
//     } else if (prob < 0.8) {
//       return const Color(0xFFE9E9E9);
//     } else {
//       return const Color(0xFFFFFFFF);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         context.push('/post/${post.eventId}');
//       },
//       child: (post.media == null || post.media == '')
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
//               color: _getRandomColor(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     post.title,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: AppColors.black,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Expanded(
//                     child: Text(
//                       post.content ?? '',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: AppColors.black,
//                         height: 1.2,
//                       ),
//                       softWrap: true,
//                       maxLines: 5,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Image.network(
//               post.media!,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//     );
//   }
// }
