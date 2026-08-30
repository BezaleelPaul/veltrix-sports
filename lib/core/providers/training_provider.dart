import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_model.dart';
import '../repositories/training_repository.dart';

final trainingRepositoryProvider = Provider((ref) => TrainingRepository());

final trainingPlansProvider = FutureProvider<List<TrainingPlan>>((ref) async {
  return ref.read(trainingRepositoryProvider).getTrainingPlans();
});

final trainingPlanDetailProvider = FutureProvider.family<TrainingPlan?, String>((ref, id) async {
  return ref.read(trainingRepositoryProvider).getTrainingPlanById(id);
});

final selectedSportFilterProvider = StateProvider<String?>((ref) => null);
