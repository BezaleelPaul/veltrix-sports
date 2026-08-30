import '../models/training_model.dart';
import '../models/event_model.dart';
import '../models/ticket_model.dart';
import '../models/coach_model.dart';
import '../models/user_model.dart';

class MockData {
  static UserModel get currentUser => UserModel.mock();

  static List<TrainingPlan> get trainingPlans => [
    TrainingPlan(id: '1', title: 'Marathon Training Pro', coachName: 'Coach Rajesh', sport: 'Running', description: 'Complete marathon training plan for intermediate runners. Build endurance, speed, and race-day strategy.', price: 2999, rating: 4.8, totalReviews: 156, durationWeeks: 12, difficulty: 'Intermediate', features: ['Personalized weekly schedule', 'Video demonstrations', 'Nutrition guide', 'Race day strategy', 'Weekly progress reviews']),
    TrainingPlan(id: '2', title: 'Swimming Mastery', coachName: 'Coach Priya', sport: 'Swimming', description: 'Master all four swimming strokes with expert guidance. Perfect for competitive swimmers.', price: 3499, rating: 4.9, totalReviews: 98, durationWeeks: 8, difficulty: 'Advanced', features: ['Stroke analysis', 'Video feedback', 'Endurance building', 'Competition prep']),
    TrainingPlan(id: '3', title: 'Cycling Endurance', coachName: 'Coach Amit', sport: 'Cycling', description: 'Build cycling endurance for long-distance rides and races.', price: 1999, rating: 4.7, totalReviews: 124, durationWeeks: 10, difficulty: 'Beginner', features: ['Progressive training', 'Nutrition plan', 'Recovery sessions']),
    TrainingPlan(id: '4', title: 'Triathlon Complete', coachName: 'Coach Vikram', sport: 'Triathlon', description: 'All-in-one triathlon training covering swimming, cycling, and running.', price: 4999, rating: 4.6, totalReviews: 67, durationWeeks: 16, difficulty: 'Advanced', features: ['Multi-sport planning', 'Transition training', 'Race strategy']),
    TrainingPlan(id: '5', title: 'Fitness Foundations', coachName: 'Coach Sneha', sport: 'Fitness', description: 'Build a strong fitness foundation with strength, flexibility, and cardio.', price: 1499, rating: 4.8, totalReviews: 203, durationWeeks: 6, difficulty: 'Beginner', features: ['Full body workouts', 'Flexibility training', 'Beginner friendly']),
  ];

  static List<EventModel> get events => [
    EventModel(id: '1', name: 'Mumbai Marathon 2026', sport: 'Running', description: 'India\'s largest marathon with 50,000+ runners.', eventDate: DateTime(2026, 2, 15), registrationDeadline: DateTime(2026, 1, 31), location: 'Marine Drive, Mumbai', city: 'Mumbai', registrationFee: 1500, maxParticipants: 50000, currentParticipants: 38420, rating: 4.9, categories: ['Full Marathon', 'Half Marathon', '10K', '5K'], rules: ['Age 18+ for full marathon', 'Valid ID required', 'Medical certificate for 42K']),
    EventModel(id: '2', name: 'Delhi Cycling Grand Prix', sport: 'Cycling', description: 'Premier cycling event through the streets of Delhi.', eventDate: DateTime(2026, 3, 20), registrationDeadline: DateTime(2026, 3, 5), location: 'India Gate Circuit, Delhi', city: 'Delhi', registrationFee: 2000, maxParticipants: 5000, currentParticipants: 3200, rating: 4.7, categories: ['Elite', 'Amateur', 'Junior'], rules: ['Certified helmet required', 'Road bikes only']),
    EventModel(id: '3', name: 'Goa Triathlon Challenge', sport: 'Triathlon', description: 'Sprint and Olympic distance triathlon in beautiful Goa.', eventDate: DateTime(2026, 4, 10), registrationDeadline: DateTime(2026, 3, 25), location: 'Baga Beach, Goa', city: 'Goa', registrationFee: 3500, maxParticipants: 2000, currentParticipants: 1450, rating: 4.8, categories: ['Sprint', 'Olympic', 'Relay'], rules: ['Wetsuit recommended', 'Own equipment required']),
    EventModel(id: '4', name: 'Bangalore Open Swim', sport: 'Swimming', description: 'Open water swimming event in Bangalore.', eventDate: DateTime(2026, 5, 5), registrationDeadline: DateTime(2026, 4, 20), location: 'Ulsoor Lake, Bangalore', city: 'Bangalore', registrationFee: 800, maxParticipants: 1000, currentParticipants: 720, rating: 4.5, categories: ['1K', '2K', '5K'], rules: ['Swimming ability required', 'Safety briefing mandatory']),
  ];

  static List<TicketModel> get tickets => [
    TicketModel(id: '1', eventId: '1', eventName: 'Mumbai Marathon 2026', category: 'Half Marathon', price: 1500, eventDate: DateTime(2026, 2, 15), seatInfo: 'Bib #A1234', status: 'active', qrCode: 'MM2026-HM-A1234'),
    TicketModel(id: '2', eventId: '3', eventName: 'Goa Triathlon Challenge', category: 'Sprint', price: 3500, eventDate: DateTime(2026, 4, 10), seatInfo: 'Start Wave 2', status: 'active', qrCode: 'GTC2026-SP-W2'),
  ];

  static List<CoachModel> get coaches => [
    CoachModel(id: '1', name: 'Coach Rajesh Kumar', sport: 'Running', bio: 'Former national level marathon runner with 15+ years coaching experience.', rating: 4.8, totalReviews: 156, yearsExperience: 15, specializations: ['Marathon', 'Half Marathon', 'Sprint', 'Endurance'], sessionPrice: 1500, isAvailable: true),
    CoachModel(id: '2', name: 'Coach Priya Menon', sport: 'Swimming', bio: 'Olympic swimmer turned coach. Specializes in competitive swimming.', rating: 4.9, totalReviews: 98, yearsExperience: 12, specializations: ['Freestyle', 'Butterfly', 'Backstroke', 'Competition'], sessionPrice: 2000, isAvailable: true),
    CoachModel(id: '3', name: 'Coach Amit Patel', sport: 'Cycling', bio: 'Tour of India winner. Expert in road cycling and triathlon training.', rating: 4.7, totalReviews: 124, yearsExperience: 10, specializations: ['Road Cycling', 'Track', 'Endurance', 'Triathlon'], sessionPrice: 1800, isAvailable: false),
    CoachModel(id: '4', name: 'Coach Vikram Singh', sport: 'Triathlon', bio: 'Ironman finisher and certified triathlon coach.', rating: 4.6, totalReviews: 67, yearsExperience: 8, specializations: ['Triathlon', 'Ironman', 'Transition', 'Multi-sport'], sessionPrice: 2500, isAvailable: true),
    CoachModel(id: '5', name: 'Coach Sneha Reddy', sport: 'Fitness', bio: 'Certified fitness trainer specializing in athletic conditioning.', rating: 4.8, totalReviews: 203, yearsExperience: 7, specializations: ['Strength', 'Conditioning', 'Flexibility', 'Recovery'], sessionPrice: 1200, isAvailable: true),
  ];
}
