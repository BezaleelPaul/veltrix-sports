class TicketModel {
  final String id;
  final String eventId;
  final String eventName;
  final String category;
  final double price;
  final DateTime eventDate;
  final String seatInfo;
  final String status; // 'active', 'used', 'cancelled'
  final String qrCode;

  TicketModel({required this.id, required this.eventId, required this.eventName, required this.category, required this.price, required this.eventDate, required this.seatInfo, required this.status, required this.qrCode});
}
