import '../models/ticket_model.dart';
import '../mock/mock_data.dart';

class TicketRepository {
  Future<List<TicketModel>> getTickets() async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.tickets;
  }

  Future<TicketModel?> getTicketById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return MockData.tickets.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<TicketModel> purchaseTicket(String eventId, String category) async {
    await Future.delayed(const Duration(seconds: 2));
    final event = MockData.events.firstWhere((e) => e.id == eventId);
    return TicketModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      eventName: event.name,
      category: category,
      price: event.registrationFee,
      eventDate: event.eventDate,
      seatInfo: 'Bib #${DateTime.now().millisecondsSinceEpoch}',
      status: 'active',
      qrCode: '${event.name.replaceAll(' ', '').substring(0, 3).toUpperCase()}-${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
