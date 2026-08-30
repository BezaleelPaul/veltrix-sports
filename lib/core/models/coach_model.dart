import 'package:equatable/equatable.dart';

class CoachModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String? profilePicture;
  final String sport;
  final String bio;
  final double rating;
  final int totalReviews;
  final int totalStudents;
  final int yearsExperience;
  final double sessionPrice;
  final List<String> specializations;
  final List<CoachPlan> plans;
  final DateTime createdAt;

  const CoachModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePicture,
    required this.sport,
    required this.bio,
    required this.rating,
    required this.totalReviews,
    required this.totalStudents,
    required this.yearsExperience,
    required this.sessionPrice,
    required this.specializations,
    required this.plans,
    required this.createdAt,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    return CoachModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profilePicture: json['profile_picture'],
      sport: json['sport'] ?? '',
      bio: json['bio'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      totalStudents: json['total_students'] ?? 0,
      yearsExperience: json['years_experience'] ?? 0,
      sessionPrice: (json['session_price'] ?? 0).toDouble(),
      specializations: (json['specializations'] as List<dynamic>?)
              ?.map((spec) => spec.toString())
              .toList() ??
          [],
      plans: (json['plans'] as List<dynamic>?)
              ?.map((plan) => CoachPlan.fromJson(plan))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_picture': profilePicture,
      'sport': sport,
      'bio': bio,
      'rating': rating,
      'total_reviews': totalReviews,
      'total_students': totalStudents,
      'years_experience': yearsExperience,
      'session_price': sessionPrice,
      'specializations': specializations,
      'plans': plans.map((plan) => plan.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        email,
        phone,
        profilePicture,
        sport,
        bio,
        rating,
        totalReviews,
        totalStudents,
        yearsExperience,
        sessionPrice,
        specializations,
        plans,
        createdAt,
      ];
}

class CoachPlan extends Equatable {
  final String id;
  final String name;
  final int durationWeeks;
  final double price;
  final String level;

  const CoachPlan({
    required this.id,
    required this.name,
    required this.durationWeeks,
    required this.price,
    required this.level,
  });

  factory CoachPlan.fromJson(Map<String, dynamic> json) {
    return CoachPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      durationWeeks: json['duration_weeks'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      level: json['level'] ?? 'beginner',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration_weeks': durationWeeks,
      'price': price,
      'level': level,
    };
  }

  @override
  List<Object?> get props => [id, name, durationWeeks, price, level];
}
