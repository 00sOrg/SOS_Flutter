import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HomeSearchBar extends ConsumerWidget {
  
  const HomeSearchBar({super.key});

// class HomeSearchBar extends ConsumerStatefulWidget {
//   final Function(bool) toggleOverlay;

//   const HomeSearchBar({super.key, required this.toggleOverlay});

//   @override
//   ConsumerState<HomeSearchBar> createState() => _HomeSearchBarState();
// }

// class _HomeSearchBarState extends ConsumerState<HomeSearchBar> {
//   late FocusNode _focusNode;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();

//     _focusNode.addListener(() {
//       if (_focusNode.hasFocus) {
//         widget.toggleOverlay(true); // Show overlay
//       } else {
//         widget.toggleOverlay(false); // Hide overlay
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

  // void _dismissKeyboard() {
  //   _focusNode
  //       .unfocus(); // Remove focus from the text field, hides the keyboard
  //   setState(() {
  //     _isOverlayVisible = false;
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 42,
        child: TextField(
          autofocus: false,
          // focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
            border: AppBorders.thickLightBlueBorder,
            focusedBorder: AppBorders.thickBlueBorder,
            enabledBorder: AppBorders.thickLightBlueBorder,
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
            // suffixIcon: const Icon(Icons.search, size: 26),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0), // 패딩을 추가하여 아이콘 크기 조정
              child: SvgPicture.asset(
                'assets/icons/home/home_search.svg',
                width: 16, // 원하는 크기로 설정
                height: 16,
                fit: BoxFit.contain,
              ),
            ),
          ),
          cursorHeight: 20,
          autocorrect: false,
          onChanged: (query) {},
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
