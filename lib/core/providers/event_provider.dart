import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../repositories/event_repository.dart';

final eventRepositoryProvider = Provider((ref) => EventRepository());

final eventsProvider = FutureProvider<List<EventModel>>((ref) async {
  return ref.read(eventRepositoryProvider).getEvents();
});

final eventDetailProvider = FutureProvider.family<EventModel?, String>((ref, id) async {
  return ref.read(eventRepositoryProvider).getEventById(id);
});

final selectedEventSportFilterProvider = StateProvider<String?>((ref) => null);
