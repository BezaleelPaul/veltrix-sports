import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../mock/mock_data.dart';

class AuthRepository {
  final FlutterSecureStorage _storage;

  AuthRepository({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock login - accept any credentials
    final user = MockData.currentUser.copyWith(
      email: email,
      name: email.split('@').first,
    );
    await _storage.write(key: 'auth_token', value: 'mock_token_123');
    return user;
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String userType,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock signup
    final user = UserModel(
      id: '2',
      name: name,
      email: email,
      phone: phone,
      userType: userType,
      createdAt: DateTime.now(),
    );
    await _storage.write(key: 'auth_token', value: 'mock_token_123');
    return user;
  }

  Future<void> verifyOtp(String phone, String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock OTP verification - accept any OTP
    if (otp.length != 6) {
      throw Exception('Invalid OTP');
    }
  }

  Future<void> resendOtp(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock resend OTP
  }

  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock forgot password
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) return null;

      // Return mock user if token exists
      return MockData.currentUser;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }
}
