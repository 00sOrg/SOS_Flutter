import 'package:flutter_riverpod/flutter_riverpod.dart';

// 바텀시트 로직 관련 필요한 코드는 여기에 보관
class BottomSheetViewModel extends StateNotifier<double> {
  BottomSheetViewModel() : super(0.2); // 기본적으로 바텀시트는 20% 열린 상태

  void setSheetPercentage(double percentage) {
    if (percentage != state) {
      state = percentage;
    }
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, double>((ref) {
  return BottomSheetViewModel();
});
