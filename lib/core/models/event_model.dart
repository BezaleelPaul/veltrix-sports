import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String organizerId;
  final String organizerName;
  final String sport; // 'running', 'cycling', 'triathlon', 'swimming'
  final DateTime eventDate;
  final String eventTime;
  final String location;
  final String? venueDetails;
  final double registrationFee;
  final int maxParticipants;
  final int currentParticipants;
  final String? imageUrl;
  final List<EventCategory> categories;
  final List<String> rules;
  final DateTime createdAt;

  const EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.organizerId,
    required this.organizerName,
    required this.sport,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    this.venueDetails,
    required this.registrationFee,
    required this.maxParticipants,
    required this.currentParticipants,
    this.imageUrl,
    required this.categories,
    required this.rules,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      organizerId: json['organizer_id'] ?? '',
      organizerName: json['organizer_name'] ?? '',
      sport: json['sport'] ?? '',
      eventDate: DateTime.parse(json['event_date'] ?? DateTime.now().toIso8601String()),
      eventTime: json['event_time'] ?? '',
      location: json['location'] ?? '',
      venueDetails: json['venue_details'],
      registrationFee: (json['registration_fee'] ?? 0).toDouble(),
      maxParticipants: json['max_participants'] ?? 0,
      currentParticipants: json['current_participants'] ?? 0,
      imageUrl: json['image_url'],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((cat) => EventCategory.fromJson(cat))
              .toList() ??
          [],
      rules: (json['rules'] as List<dynamic>?)
              ?.map((rule) => rule.toString())
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'organizer_id': organizerId,
      'organizer_name': organizerName,
      'sport': sport,
      'event_date': eventDate.toIso8601String(),
      'event_time': eventTime,
      'location': location,
      'venue_details': venueDetails,
      'registration_fee': registrationFee,
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'image_url': imageUrl,
      'categories': categories.map((cat) => cat.toJson()).toList(),
      'rules': rules,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        organizerId,
        organizerName,
        sport,
        eventDate,
        eventTime,
        location,
        venueDetails,
        registrationFee,
        maxParticipants,
        currentParticipants,
        imageUrl,
        categories,
        rules,
        createdAt,
      ];
}

class EventCategory extends Equatable {
  final String id;
  final String name;
  final String distance;
  final double price;
  final int maxParticipants;

  const EventCategory({
    required this.id,
    required this.name,
    required this.distance,
    required this.price,
    required this.maxParticipants,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      distance: json['distance'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      maxParticipants: json['max_participants'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'distance': distance,
      'price': price,
      'max_participants': maxParticipants,
    };
  }

  @override
  List<Object?> get props => [id, name, distance, price, maxParticipants];
}
