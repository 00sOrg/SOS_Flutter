import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';

class BottomSheetContent extends ConsumerWidget {
  final List<String> dummyData = List.generate(10, (index) => 'Event $index');

  BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 20프로에서 올렸을때 -> listview 바꾸기 (주변상황 -> 리스트)
    return Column(
      children: [
        Center(
          child: Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          height: 100,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          alignment: Alignment.center,
          child: const Text('현재 위치 및 사건 수'),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dummyData[index]),
                onTap: () => ref
                    .read(bottomSheetViewModelProvider.notifier)
                    .navigateToPost(context, index),
              );
            },
            separatorBuilder: (context, index) => Divider(
              thickness: 0.5,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
