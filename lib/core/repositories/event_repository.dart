import '../models/event_model.dart';
import '../mock/mock_data.dart';

class EventRepository {
  Future<List<EventModel>> getEvents({String? sport, String? city}) async {
    await Future.delayed(const Duration(seconds: 1));
    var events = MockData.events;
    if (sport != null) events = events.where((e) => e.sport == sport).toList();
    if (city != null) events = events.where((e) => e.city == city).toList();
    return events;
  }

  Future<EventModel?> getEventById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return MockData.events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
