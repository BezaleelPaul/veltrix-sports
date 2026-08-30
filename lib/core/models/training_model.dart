import 'package:equatable/equatable.dart';

class TrainingPlan extends Equatable {
  final String id;
  final String name;
  final String description;
  final String coachId;
  final String coachName;
  final String sport; // 'running', 'triathlon', 'biking', 'nutrition', 'hydration', 'strength'
  final String level; // 'beginner', 'intermediate', 'advanced'
  final int durationWeeks;
  final double price;
  final double rating;
  final int totalStudents;
  final String? imageUrl;
  final List<TrainingWeek> weeks;
  final DateTime createdAt;

  const TrainingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.coachId,
    required this.coachName,
    required this.sport,
    required this.level,
    required this.durationWeeks,
    required this.price,
    required this.rating,
    required this.totalStudents,
    this.imageUrl,
    required this.weeks,
    required this.createdAt,
  });

  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coachId: json['coach_id'] ?? '',
      coachName: json['coach_name'] ?? '',
      sport: json['sport'] ?? '',
      level: json['level'] ?? 'beginner',
      durationWeeks: json['duration_weeks'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      totalStudents: json['total_students'] ?? 0,
      imageUrl: json['image_url'],
      weeks: (json['weeks'] as List<dynamic>?)
              ?.map((week) => TrainingWeek.fromJson(week))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coach_id': coachId,
      'coach_name': coachName,
      'sport': sport,
      'level': level,
      'duration_weeks': durationWeeks,
      'price': price,
      'rating': rating,
      'total_students': totalStudents,
      'image_url': imageUrl,
      'weeks': weeks.map((week) => week.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        coachId,
        coachName,
        sport,
        level,
        durationWeeks,
        price,
        rating,
        totalStudents,
        imageUrl,
        weeks,
        createdAt,
      ];
}

class TrainingWeek extends Equatable {
  final String id;
  final int weekNumber;
  final String title;
  final List<TrainingSession> sessions;

  const TrainingWeek({
    required this.id,
    required this.weekNumber,
    required this.title,
    required this.sessions,
  });

  factory TrainingWeek.fromJson(Map<String, dynamic> json) {
    return TrainingWeek(
      id: json['id'] ?? '',
      weekNumber: json['week_number'] ?? 0,
      title: json['title'] ?? '',
      sessions: (json['sessions'] as List<dynamic>?)
              ?.map((session) => TrainingSession.fromJson(session))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'week_number': weekNumber,
      'title': title,
      'sessions': sessions.map((session) => session.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, weekNumber, title, sessions];
}

class TrainingSession extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? videoUrl;
  final int durationMinutes;
  final List<Exercise> exercises;
  final bool isCompleted;

  const TrainingSession({
    required this.id,
    required this.title,
    this.description,
    this.videoUrl,
    required this.durationMinutes,
    required this.exercises,
    this.isCompleted = false,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      videoUrl: json['video_url'],
      durationMinutes: json['duration_minutes'] ?? 0,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((exercise) => Exercise.fromJson(exercise))
              .toList() ??
          [],
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'duration_minutes': durationMinutes,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
      'is_completed': isCompleted,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoUrl,
        durationMinutes,
        exercises,
        isCompleted,
      ];
}

class Exercise extends Equatable {
  final String id;
  final String name;
  final String? description;
  final int? sets;
  final int? reps;
  final int? durationSeconds;
  final String? videoUrl;

  const Exercise({
    required this.id,
    required this.name,
    this.description,
    this.sets,
    this.reps,
    this.durationSeconds,
    this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      sets: json['sets'],
      reps: json['reps'],
      durationSeconds: json['duration_seconds'],
      videoUrl: json['video_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'duration_seconds': durationSeconds,
      'video_url': videoUrl,
    };
  }

  @override
  List<Object?> get props => [id, name, description, sets, reps, durationSeconds, videoUrl];
}
