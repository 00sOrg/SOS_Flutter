import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? hasLeading;
  final Widget? trailingAction;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasLeading = true,
    this.trailingAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: hasLeading!
            ? IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 26,
                ),
              )
            : const SizedBox.shrink(),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          trailingAction ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // Size get preferredSize => const Size.fromHeight(56);
}
