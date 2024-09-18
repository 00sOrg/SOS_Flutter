import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/repositories/friends_repository.dart';

final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  return FriendsRepository();
});
