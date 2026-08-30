import '../models/ticket_model.dart';
import '../mock/mock_data.dart';

class TicketRepository {
  Future<List<TicketModel>> getMyTickets({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var tickets = MockData.tickets;

    if (status != null) {
      tickets = tickets.where((t) => t.status == status).toList();
    }

    return tickets;
  }

  Future<TicketModel> getTicket(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final ticket = MockData.tickets.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Ticket not found'),
    );
    return ticket;
  }

  Future<TicketModel> purchaseTicket({
    required String eventId,
    required String categoryId,
    required String seat,
    required double price,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock purchase
    return TicketModel(
      id: '3',
      eventId: eventId,
      eventName: 'New Event',
      userId: '1',
      category: categoryId,
      seat: seat,
      price: price,
      bookingId: 'VTX-2026-003',
      qrCode: 'QR1234567890',
      status: 'confirmed',
      eventDate: DateTime.now().add(const Duration(days: 30)),
      eventTime: '10:00 AM',
      venue: 'Mumbai',
      purchasedAt: DateTime.now(),
    );
  }

  Future<void> cancelTicket(String ticketId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock cancel
  }

  Future<void> transferTicket(String ticketId, String toUserId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock transfer
  }

  Future<String> getTicketQrCode(String ticketId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'MOCK_QR_CODE_${DateTime.now().millisecondsSinceEpoch}';
  }
}
