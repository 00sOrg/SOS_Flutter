import 'package:flutter/material.dart';

class FavoritesDropdown extends StatelessWidget {
  final List<String> dummyUsers = ['user1', 'user2', 'user3', 'user4', 'user5'];

  FavoritesDropdown({super.key});

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: Center(
                        child: Text(item),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
