import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../repositories/ticket_repository.dart';

// Ticket Repository Provider
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepository();
});

// My Tickets Provider
final myTicketsProvider = FutureProvider.autoDispose<List<TicketModel>>((ref) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getMyTickets();
});

// Upcoming Tickets Provider
final upcomingTicketsProvider = FutureProvider.autoDispose<List<TicketModel>>((ref) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getMyTickets(status: 'confirmed');
});

// Past Tickets Provider
final pastTicketsProvider = FutureProvider.autoDispose<List<TicketModel>>((ref) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getMyTickets(status: 'used');
});

// Ticket Details Provider
final ticketDetailsProvider = FutureProvider.autoDispose.family<TicketModel, String>((ref, id) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getTicket(id);
});

// Ticket QR Code Provider
final ticketQrCodeProvider = FutureProvider.autoDispose.family<String, String>((ref, ticketId) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getTicketQrCode(ticketId);
});
