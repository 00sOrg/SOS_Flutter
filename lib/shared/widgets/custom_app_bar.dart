import 'package:flutter/material.dart';

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
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: hasLeading!
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                ),
              )
            : const SizedBox.shrink(),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        actions: [
          (trailingAction == null)
              ? IconButton(
                  onPressed: () {
                    debugPrint('MORE button pressed');
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    size: 24,
                  ),
                )
              : trailingAction!,
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
