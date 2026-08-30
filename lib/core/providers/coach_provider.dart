import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coach_model.dart';
import '../repositories/coach_repository.dart';

final coachRepositoryProvider = Provider((ref) => CoachRepository());

final coachesProvider = FutureProvider<List<CoachModel>>((ref) async {
  return ref.read(coachRepositoryProvider).getCoaches();
});

final coachDetailProvider = FutureProvider.family<CoachModel?, String>((ref, id) async {
  return ref.read(coachRepositoryProvider).getCoachById(id);
});
