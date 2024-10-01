import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/setting/repositories/setting_repository.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/utils/log_util.dart';

class SettingMypostViewmodel extends StateNotifier<List<Board>> {
  final SettingRepository settingRepository;

  SettingMypostViewmodel(this.settingRepository) : super([]);

  Future<void> refreshBoard() async {
    try {
      final boardList = await settingRepository.getMyBoardList();
      state = boardList;
      // return true;
    } catch (e) {
      LogUtil.e('refreshMyBoard 에러: $e');
      throw Exception();
    }
  }
}

final settingMypostViewmodelProvider =
    StateNotifierProvider<SettingMypostViewmodel, List<Board>>((ref) {
  return SettingMypostViewmodel(ref.read(settingRepositoryProvider));
});
