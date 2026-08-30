import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/coach_provider.dart';

final selectedCoachSportFilterProvider = StateProvider<String?>((ref) => null);

class CoachesListScreen extends ConsumerWidget {
  const CoachesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coachesAsync = ref.watch(coachesProvider);
    final selectedSport = ref.watch(selectedCoachSportFilterProvider);
    final sports = ['All', 'Running', 'Swimming', 'Cycling', 'Triathlon', 'Fitness'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Coaches', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
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
                        ref.read(selectedCoachSportFilterProvider.notifier).state = sport == 'All' ? null : sport;
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: coachesAsync.when(
                data: (coaches) {
                  final filtered = selectedSport != null
                      ? coaches.where((c) => c.sport == selectedSport).toList()
                      : coaches;
                  if (filtered.isEmpty) {
                    return Center(child: Text('No coaches found', style: TextStyle(color: AppColors.textSecondary)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => _buildCoachCard(context, filtered[i]),
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

  Widget _buildCoachCard(BuildContext context, dynamic coach) {
    return GestureDetector(
      onTap: () => context.push('/coaches/${coach.id}'),
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
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                coach.name.split(' ').last[0],
                style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coach.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('${coach.sport} · ${coach.yearsExperience} years exp', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text('${coach.rating} (${coach.totalReviews})', style: TextStyle(fontSize: 13)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: coach.isAvailable ? AppColors.success.withOpacity(0.1) : AppColors.grey300.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          coach.isAvailable ? 'Available' : 'Busy',
                          style: TextStyle(
                            color: coach.isAvailable ? AppColors.success : AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
