import 'package:flutter_riverpod/flutter_riverpod.dart';

// 바텀시트 로직 관련 필요한 코드는 여기에 보관
// 이건 그냥 예시 코드니까 클래스명 빼고 다 본인에게 맞게 조정하세여
//// 특히 StateNotier<void> 인 부분
//// 다른 ViewModel들 참고해서 필요한 형태로 고치기
class BottomSheetViewModel extends StateNotifier<void> {
  bool isBottomSheetOpen = false;

  BottomSheetViewModel() : super(null);

  // 이건 그냥 예시 코드
  // 우리는 실제로 완전한 토글 (있-없)을 하는 게 아니라
  // 조금 열렸냐 많이 열렸냐를 해야하는 거기 때문에 요거 그대로 쓰면 안되고 수정해야돼유
  void toggleBottomSheet() {
    isBottomSheetOpen = !isBottomSheetOpen;
    state = null; // 이런식으로 state update trigger 하는거 별로니까 니즈에 맞게 수정하세여
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, void>((ref) {
  return BottomSheetViewModel();
});
