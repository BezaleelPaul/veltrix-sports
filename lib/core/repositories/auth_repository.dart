import '../models/user_model.dart';
import '../mock/mock_data.dart';

class AuthRepository {
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.currentUser;
  }

  Future<UserModel> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.currentUser;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.currentUser;
  }
}
