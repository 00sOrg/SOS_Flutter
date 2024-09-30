import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});
