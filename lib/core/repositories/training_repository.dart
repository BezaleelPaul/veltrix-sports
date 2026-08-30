import '../models/training_model.dart';
import '../mock/mock_data.dart';

class TrainingRepository {
  Future<List<TrainingPlan>> getTrainingPlans({String? sport, String? difficulty}) async {
    await Future.delayed(const Duration(seconds: 1));
    var plans = MockData.trainingPlans;
    if (sport != null) plans = plans.where((p) => p.sport == sport).toList();
    if (difficulty != null) plans = plans.where((p) => p.difficulty == difficulty).toList();
    return plans;
  }

  Future<TrainingPlan?> getTrainingPlanById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return MockData.trainingPlans.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
