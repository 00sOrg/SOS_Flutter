import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';

class FavoritesDropdown extends ConsumerWidget {
  final List<String> dummyUsers = ['user1', 'user2', 'user3', 'user4', 'user5'];

  FavoritesDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xFFDADADA).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: dummyUsers.map(
          // todo: [Cherrie] Change to Listview.builder or separater
          (item) {
            return InkWell(
              child: Container(
                height: 35,
                alignment: Alignment.center,
                child: Text(item),
              ),
              onTap: () {
                ref
                    .read(homeViewModelProvider.notifier)
                    .navigateToUser(context, item);
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
