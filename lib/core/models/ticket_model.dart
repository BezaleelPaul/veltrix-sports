import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
  final String id;
  final String eventId;
  final String eventName;
  final String userId;
  final String category;
  final String seat;
  final double price;
  final String bookingId;
  final String qrCode;
  final String status; // 'confirmed', 'pending', 'cancelled'
  final DateTime eventDate;
  final String eventTime;
  final String venue;
  final DateTime purchasedAt;

  const TicketModel({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.userId,
    required this.category,
    required this.seat,
    required this.price,
    required this.bookingId,
    required this.qrCode,
    required this.status,
    required this.eventDate,
    required this.eventTime,
    required this.venue,
    required this.purchasedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? '',
      eventId: json['event_id'] ?? '',
      eventName: json['event_name'] ?? '',
      userId: json['user_id'] ?? '',
      category: json['category'] ?? '',
      seat: json['seat'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      bookingId: json['booking_id'] ?? '',
      qrCode: json['qr_code'] ?? '',
      status: json['status'] ?? 'confirmed',
      eventDate: DateTime.parse(json['event_date'] ?? DateTime.now().toIso8601String()),
      eventTime: json['event_time'] ?? '',
      venue: json['venue'] ?? '',
      purchasedAt: DateTime.parse(json['purchased_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'event_name': eventName,
      'user_id': userId,
      'category': category,
      'seat': seat,
      'price': price,
      'booking_id': bookingId,
      'qr_code': qrCode,
      'status': status,
      'event_date': eventDate.toIso8601String(),
      'event_time': eventTime,
      'venue': venue,
      'purchased_at': purchasedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        eventName,
        userId,
        category,
        seat,
        price,
        bookingId,
        qrCode,
        status,
        eventDate,
        eventTime,
        venue,
        purchasedAt,
      ];
}
