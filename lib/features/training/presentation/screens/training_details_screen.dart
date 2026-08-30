import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/training_provider.dart';

class TrainingDetailsScreen extends ConsumerWidget {
  final String id;
  const TrainingDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(trainingPlanDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: planAsync.when(
        data: (plan) {
          if (plan == null) return const Center(child: Text('Plan not found'));
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(plan.title, style: GoogleFonts.poppins()),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.fitness_center, size: 80, color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildChip(plan.sport),
                          const SizedBox(width: 8),
                          _buildChip(plan.difficulty),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.warning),
                          const SizedBox(width: 4),
                          Text('${plan.rating} (${plan.totalReviews} reviews)', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Text('₹${plan.price.toInt()}', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('About', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(plan.description, style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
                      const SizedBox(height: 24),
                      Text('Features', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...plan.features.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(child: Text(f)),
                          ],
                        ),
                      )),
                      const SizedBox(height: 24),
                      Text('Coach: ${plan.coachName}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {},
            child: Text('Enroll Now', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
    );
  }
}
