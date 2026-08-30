import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_model.dart';
import '../repositories/training_repository.dart';

// Training Repository Provider
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  return TrainingRepository();
});

// Training Plans List Provider
final trainingPlansProvider = FutureProvider.autoDispose<List<TrainingPlan>>((ref) async {
  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getTrainingPlans();
});

// Training Plan Details Provider
final trainingPlanDetailsProvider = FutureProvider.autoDispose.family<TrainingPlan, String>((ref, id) async {
  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getTrainingPlan(id);
});

// Popular Plans Provider
final popularPlansProvider = FutureProvider.autoDispose<List<TrainingPlan>>((ref) async {
  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getPopularPlans();
});

// Recommended Plans Provider
final recommendedPlansProvider = FutureProvider.autoDispose<List<TrainingPlan>>((ref) async {
  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getRecommendedPlans();
});

// Training Filter State
class TrainingFilterState {
  final String? sport;
  final String? level;
  final String? search;

  TrainingFilterState({
    this.sport,
    this.level,
    this.search,
  });

  TrainingFilterState copyWith({
    String? sport,
    String? level,
    String? search,
  }) {
    return TrainingFilterState(
      sport: sport ?? this.sport,
      level: level ?? this.level,
      search: search ?? this.search,
    );
  }
}

// Training Filter Provider
final trainingFilterProvider = StateProvider<TrainingFilterState>((ref) {
  return TrainingFilterState();
});

// Filtered Training Plans Provider
final filteredTrainingPlansProvider = FutureProvider.autoDispose<List<TrainingPlan>>((ref) async {
  final repository = ref.watch(trainingRepositoryProvider);
  final filter = ref.watch(trainingFilterProvider);
  return repository.getTrainingPlans(
    sport: filter.sport,
    level: filter.level,
    search: filter.search,
  );
});

// Training Progress Provider
final trainingProgressProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, planId) async {
  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getProgress(planId);
});
