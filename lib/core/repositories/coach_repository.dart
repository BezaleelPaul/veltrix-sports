import '../models/coach_model.dart';
import '../mock/mock_data.dart';

class CoachRepository {
  Future<List<CoachModel>> getCoaches({String? sport}) async {
    await Future.delayed(const Duration(seconds: 1));
    var coaches = MockData.coaches;
    if (sport != null) coaches = coaches.where((c) => c.sport == sport).toList();
    return coaches;
  }

  Future<CoachModel?> getCoachById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return MockData.coaches.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
