import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String role; // 'athlete', 'coach', 'organizer'
  final DateTime createdAt;

  UserModel({required this.id, required this.name, required this.email, this.phone = '', this.avatarUrl, this.role = 'athlete', required this.createdAt});

  factory UserModel.mock() => UserModel(
    id: '1', name: 'Arjun Sharma', email: 'arjun@email.com', phone: '+91 98765 43210',
    role: 'athlete', createdAt: DateTime(2024, 1, 15),
  );
}
