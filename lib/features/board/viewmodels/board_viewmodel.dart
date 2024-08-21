import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boardViewModelProvider = Provider((ref) => BoardViewModel());

class BoardViewModel {
  void refreshBoard() {
    debugPrint('REFRESH BOARD');
  }
}