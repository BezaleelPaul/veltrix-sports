import '../models/training_model.dart';
import '../mock/mock_data.dart';

class TrainingRepository {
  Future<List<TrainingPlan>> getTrainingPlans({
    String? sport,
    String? level,
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var plans = MockData.trainingPlans;

    if (sport != null) {
      plans = plans.where((p) => p.sport.toLowerCase() == sport.toLowerCase()).toList();
    }
    if (level != null) {
      plans = plans.where((p) => p.level.toLowerCase() == level.toLowerCase()).toList();
    }
    if (search != null) {
      plans = plans.where((p) => p.name.toLowerCase().contains(search.toLowerCase())).toList();
    }

    return plans;
  }

  Future<TrainingPlan> getTrainingPlan(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final plan = MockData.trainingPlans.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Plan not found'),
    );
    return plan;
  }

  Future<List<TrainingPlan>> getPopularPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.trainingPlans.take(3).toList();
  }

  Future<List<TrainingPlan>> getRecommendedPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.trainingPlans.take(2).toList();
  }

  Future<void> purchasePlan(String planId, double price) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock purchase
  }

  Future<void> completeSession(String planId, String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock complete session
  }

  Future<Map<String, dynamic>> getProgress(String planId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'completed_sessions': 3,
      'total_sessions': 8,
      'progress_percent': 37.5,
      'current_week': 1,
      'total_weeks': 4,
    };
  }
}
