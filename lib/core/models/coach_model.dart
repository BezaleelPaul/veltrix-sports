class CoachModel {
  final String id;
  final String name;
  final String sport;
  final String bio;
  final double rating;
  final int totalReviews;
  final int yearsExperience;
  final List<String> specializations;
  final double sessionPrice;
  final bool isAvailable;
  final String imageUrl;

  CoachModel({required this.id, required this.name, required this.sport, required this.bio, required this.rating, required this.totalReviews, required this.yearsExperience, required this.specializations, required this.sessionPrice, required this.isAvailable, this.imageUrl = ''});
}
