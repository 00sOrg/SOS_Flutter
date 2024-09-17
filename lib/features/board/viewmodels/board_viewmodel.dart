import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/board/repositories/board_repository.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/utils/log_util.dart';

class BoardViewModel extends StateNotifier<List<Board>> {
  final BoardRepository boardRepository;

  BoardViewModel(this.boardRepository) : super([]);

  Future<void> refreshBoard() async {
    try {
      final boardList = await boardRepository.getBoardList();
      state = boardList;
      // return true;
    } catch (e) {
      LogUtil.e('refreshBoard 에러: $e');
      throw Exception();
    }
  }
}

final boardViewModelProvider =
    StateNotifierProvider<BoardViewModel, List<Board>>((ref) {
  final boardRepository = ref.read(boardRepositoryProvider);
  return BoardViewModel(boardRepository);
});
