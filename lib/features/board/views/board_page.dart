import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {
  BoardPage({super.key});

  final List<String> dummyPics =
      List.generate(20, (index) => 'https://picsum.photos/20${index % 10}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: dummyPics.length,
                itemBuilder: (context, idx) {
                  return Container(
                    child: Image.network(
                      dummyPics[idx],
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
