import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<bool> {
  HomeViewModel() : super(false);

  void toggleDropdown() {
    state = !state;
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>((ref) {
  return HomeViewModel();
});
