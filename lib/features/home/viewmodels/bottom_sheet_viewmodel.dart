import 'package:flutter_riverpod/flutter_riverpod.dart';

// 바텀시트 로직 관련 필요한 코드는 여기에 보관
class BottomSheetViewModel extends StateNotifier<bool> {
  BottomSheetViewModel() : super(false);

  // 이건 그냥 예시 코드 
  // 우리는 실제로 완전한 토글 (있-없)을 하는 게 아니라
  // 조금 열렸냐 많이 열렸냐를 해야하는 거기 때문에 요거 그대로 쓰면 안되고 수정해야돼유
  void toggleBottomSheet() {
    state = !state;
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, bool>((ref) {
  return BottomSheetViewModel();
});
