import 'package:flutter_riverpod/flutter_riverpod.dart';

// 추천 주소 상태 관리
final addressSuggestionProvider =
    StateNotifierProvider<AddressSuggestionNotifier, List<String>>((ref) {
  return AddressSuggestionNotifier();
});

class AddressSuggestionNotifier extends StateNotifier<List<String>> {
  AddressSuggestionNotifier() : super([]);

  // 추천 주소 목록 업데이트
  void updateSuggestions(List<String> suggestions) {
    state = suggestions;
  }

  // 추천 주소 초기화
  void clearSuggestions() {
    state = [];
  }
}
