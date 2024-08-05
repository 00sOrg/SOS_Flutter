import 'dart:async';

class AuthService {
  Future<bool> login(String id, String password) async {
    
    await Future.delayed(const Duration(milliseconds: 700));
    if (id == 'id' && password == '0000') {
      return true;
    } else {
      return false;
    }
  }
}