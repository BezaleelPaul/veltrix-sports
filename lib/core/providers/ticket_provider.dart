import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../repositories/ticket_repository.dart';

final ticketRepositoryProvider = Provider((ref) => TicketRepository());

final ticketsProvider = FutureProvider<List<TicketModel>>((ref) async {
  return ref.read(ticketRepositoryProvider).getTickets();
});

final ticketDetailProvider = FutureProvider.family<TicketModel?, String>((ref, id) async {
  return ref.read(ticketRepositoryProvider).getTicketById(id);
});
