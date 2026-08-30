import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coach_model.dart';
import '../mock/mock_data.dart';

// Coaches Repository
class CoachRepository {
  Future<List<CoachModel>> getCoaches({
    String? sport,
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var coaches = MockData.coaches;

    if (sport != null) {
      coaches = coaches.where((c) => c.sport.toLowerCase().contains(sport.toLowerCase())).toList();
    }
    if (search != null) {
      coaches = coaches.where((c) => c.name.toLowerCase().contains(search.toLowerCase())).toList();
    }

    return coaches;
  }

  Future<CoachModel> getCoach(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final coach = MockData.coaches.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Coach not found'),
    );
    return coach;
  }

  Future<List<CoachModel>> getPopularCoaches() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.coaches.take(3).toList();
  }

  Future<void> bookSession(String coachId, Map<String, dynamic> bookingDetails) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock booking
  }
}

// Coach Repository Provider
final coachRepositoryProvider = Provider<CoachRepository>((ref) {
  return CoachRepository();
});

// Coaches List Provider
final coachesProvider = FutureProvider.autoDispose<List<CoachModel>>((ref) async {
  final repository = ref.watch(coachRepositoryProvider);
  return repository.getCoaches();
});

// Coach Details Provider
final coachDetailsProvider = FutureProvider.autoDispose.family<CoachModel, String>((ref, id) async {
  final repository = ref.watch(coachRepositoryProvider);
  return repository.getCoach(id);
});

// Popular Coaches Provider
final popularCoachesProvider = FutureProvider.autoDispose<List<CoachModel>>((ref) async {
  final repository = ref.watch(coachRepositoryProvider);
  return repository.getPopularCoaches();
});

// Coach Filter State
class CoachFilterState {
  final String? sport;
  final String? search;

  CoachFilterState({
    this.sport,
    this.search,
  });

  CoachFilterState copyWith({
    String? sport,
    String? search,
  }) {
    return CoachFilterState(
      sport: sport ?? this.sport,
      search: search ?? this.search,
    );
  }
}

// Coach Filter Provider
final coachFilterProvider = StateProvider<CoachFilterState>((ref) {
  return CoachFilterState();
});

// Filtered Coaches Provider
final filteredCoachesProvider = FutureProvider.autoDispose<List<CoachModel>>((ref) async {
  final repository = ref.watch(coachRepositoryProvider);
  final filter = ref.watch(coachFilterProvider);
  return repository.getCoaches(
    sport: filter.sport,
    search: filter.search,
  );
});
