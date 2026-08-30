class TrainingPlan {
  final String id;
  final String title;
  final String coachName;
  final String sport;
  final String description;
  final double price;
  final double rating;
  final int totalReviews;
  final int durationWeeks;
  final String difficulty; // 'Beginner', 'Intermediate', 'Advanced'
  final List<String> features;
  final String imageUrl;

  TrainingPlan({required this.id, required this.title, required this.coachName, required this.sport, required this.description, required this.price, required this.rating, required this.totalReviews, required this.durationWeeks, required this.difficulty, required this.features, this.imageUrl = ''});
}
