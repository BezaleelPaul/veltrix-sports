import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/training_provider.dart';

final selectedDifficultyFilterProvider = StateProvider<String?>((ref) => null);

class TrainingListScreen extends ConsumerWidget {
  const TrainingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingAsync = ref.watch(trainingPlansProvider);
    final selectedSport = ref.watch(selectedSportFilterProvider);
    final selectedDifficulty = ref.watch(selectedDifficultyFilterProvider);
    final sports = ['All', 'Running', 'Swimming', 'Cycling', 'Triathlon', 'Fitness'];
    final difficulties = ['All', 'Beginner', 'Intermediate', 'Advanced'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Training Plans', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sports.length,
                itemBuilder: (context, i) {
                  final sport = sports[i];
                  final isSelected = (selectedSport == null && sport == 'All') || selectedSport == sport;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(sport),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(selectedSportFilterProvider.notifier).state = sport == 'All' ? null : sport;
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: difficulties.length,
                itemBuilder: (context, i) {
                  final diff = difficulties[i];
                  final isSelected = (selectedDifficulty == null && diff == 'All') || selectedDifficulty == diff;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(diff),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(selectedDifficultyFilterProvider.notifier).state = diff == 'All' ? null : diff;
                      },
                      selectedColor: AppColors.accent,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: trainingAsync.when(
                data: (plans) {
                  var filtered = plans;
                  if (selectedSport != null) {
                    filtered = filtered.where((p) => p.sport == selectedSport).toList();
                  }
                  if (selectedDifficulty != null) {
                    filtered = filtered.where((p) => p.difficulty == selectedDifficulty).toList();
                  }
                  if (filtered.isEmpty) {
                    return Center(child: Text('No plans found', style: TextStyle(color: AppColors.textSecondary)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => _buildPlanCard(context, filtered[i]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, dynamic plan) {
    return GestureDetector(
      onTap: () => context.push('/training/${plan.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.fitness_center, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan.title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('${plan.coachName} · ${plan.durationWeeks} weeks · ${plan.difficulty}', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text('${plan.rating} (${plan.totalReviews})', style: TextStyle(fontSize: 13)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('₹${plan.price.toInt()}', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
