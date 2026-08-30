class EventModel {
  final String id;
  final String name;
  final String sport;
  final String description;
  final DateTime eventDate;
  final DateTime registrationDeadline;
  final String location;
  final String city;
  final double registrationFee;
  final int maxParticipants;
  final int currentParticipants;
  final double rating;
  final List<String> categories;
  final List<String> rules;
  final String imageUrl;

  EventModel({required this.id, required this.name, required this.sport, required this.description, required this.eventDate, required this.registrationDeadline, required this.location, required this.city, required this.registrationFee, required this.maxParticipants, required this.currentParticipants, required this.rating, required this.categories, required this.rules, this.imageUrl = ''});
}
