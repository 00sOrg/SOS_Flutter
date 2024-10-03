import 'package:flutter/material.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardTagGrid extends StatelessWidget {
  final List<String> items;
  final PostType eventType;

  const BoardTagGrid({
    super.key,
    required this.items,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {
    // List<Widget> rows = [];

    // for (int i = 0; i < items.length; i += 3) {
    //   List<String> rowItems = items.sublist(
    //     i,
    //     i + 3 > items.length ? items.length : i + 3,
    //   );

    //   rows.add(
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: rowItems
    //           .map(
    //             (item) => Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 5),
    //               child: tagBlock(text: item),
    //             ),
    //           )
    //           .toList(),
    //     ),
    //   );
    //   rows.add(const SizedBox(height: 6));
    // }

    return Wrap(
      spacing: 5, // hor
      runSpacing: 6, // vert
      children: items.map((item) => tagBlock(text: item)).toList(),
    );
  }

  Widget tagBlock({Widget? icon, required String text}) {
    final Color tagColor = text == eventType.koreanName
        ? getTagColor(eventType.name)
        : AppColors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.9),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Color(0xFF0017a7),
        //       AppColors.blue,
        //     ]),
        // color: tagColor,
        color: tagColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            getTagIcon(eventType.name, isWhite: true),
            height: 16,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
