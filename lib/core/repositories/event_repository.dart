import '../models/event_model.dart';
import '../mock/mock_data.dart';

class EventRepository {
  Future<List<EventModel>> getEvents({
    String? sport,
    String? search,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var events = MockData.events;

    if (sport != null) {
      events = events.where((e) => e.sport.toLowerCase() == sport.toLowerCase()).toList();
    }
    if (search != null) {
      events = events.where((e) => e.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
    if (startDate != null) {
      events = events.where((e) => e.eventDate.isAfter(startDate)).toList();
    }

    return events;
  }

  Future<EventModel> getEvent(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final event = MockData.events.firstWhere(
      (e) => e.id == id,
      orElse: () => throw Exception('Event not found'),
    );
    return event;
  }

  Future<List<EventModel>> getFeaturedEvents() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.events.take(2).toList();
  }

  Future<void> registerForEvent(String eventId, String categoryId, Map<String, dynamic> participantDetails) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock registration
  }

  Future<void> cancelRegistration(String eventId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock cancel
  }

  Future<List<Map<String, dynamic>>> getEventRegistrations(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {'id': '1', 'name': 'John Doe', 'status': 'confirmed'},
      {'id': '2', 'name': 'Jane Smith', 'status': 'confirmed'},
    ];
  }
}
