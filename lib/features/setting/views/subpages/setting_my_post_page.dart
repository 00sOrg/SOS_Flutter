import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/viewmodels/setting_mypost_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_board_item.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingMyPostPage extends ConsumerStatefulWidget {
  const SettingMyPostPage({super.key});

  @override
  ConsumerState<SettingMyPostPage> createState() => _SettingMyPostPageState();
}

class _SettingMyPostPageState extends ConsumerState<SettingMyPostPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingMypostViewmodelProvider.notifier).refreshBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardItems = ref.watch(settingMypostViewmodelProvider);

    return Scaffold(
        appBar: CustomAppBar(
          title: '내 게시글',
          onTapLeading: () => GoRouter.of(context).pop(),
        ),
        body: RefreshIndicator.adaptive(
          displacement: 20,
          onRefresh: () async {
            await ref
                .read(settingMypostViewmodelProvider.notifier)
                .refreshBoard();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 59 - 71 - 94,
              ),
              child: boardItems.isEmpty
                  ? const Center(
                      child: Text('게시글이 없어요'),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1,
                      ),
                      itemCount: boardItems.length,
                      itemBuilder: (context, idx) {
                        return BoardItem(post: boardItems[idx]);
                      },
                      physics: const PageScrollPhysics(),
                    ),
            ),
          ),
        ));
  }
}
