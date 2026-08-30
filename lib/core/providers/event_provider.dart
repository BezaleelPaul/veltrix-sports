import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../repositories/event_repository.dart';

// Event Repository Provider
final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository();
});

// Events List Provider
final eventsProvider = FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getEvents();
});

// Event Details Provider
final eventDetailsProvider = FutureProvider.autoDispose.family<EventModel, String>((ref, id) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getEvent(id);
});

// Featured Events Provider
final featuredEventsProvider = FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getFeaturedEvents();
});

// Event Filter State
class EventFilterState {
  final String? sport;
  final String? search;
  final DateTime? startDate;
  final DateTime? endDate;

  EventFilterState({
    this.sport,
    this.search,
    this.startDate,
    this.endDate,
  });

  EventFilterState copyWith({
    String? sport,
    String? search,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return EventFilterState(
      sport: sport ?? this.sport,
      search: search ?? this.search,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

// Event Filter Provider
final eventFilterProvider = StateProvider<EventFilterState>((ref) {
  return EventFilterState();
});

// Filtered Events Provider
final filteredEventsProvider = FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  final filter = ref.watch(eventFilterProvider);
  return repository.getEvents(
    sport: filter.sport,
    search: filter.search,
    startDate: filter.startDate,
    endDate: filter.endDate,
  );
});
