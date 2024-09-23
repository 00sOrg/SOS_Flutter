import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(); // Instantiate your UserRepository here
});
