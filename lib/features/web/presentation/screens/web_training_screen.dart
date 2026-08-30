import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebTrainingScreen extends ConsumerStatefulWidget {
  const WebTrainingScreen({super.key});

  @override
  ConsumerState<WebTrainingScreen> createState() => _WebTrainingScreenState();
}

class _WebTrainingScreenState extends ConsumerState<WebTrainingScreen> {
  String _selectedSport = 'All';
  String _selectedDifficulty = 'All';

  static const _sports = ['All', 'Running', 'Swimming', 'Cycling', 'Triathlon', 'Fitness'];
  static const _difficulties = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final plans = MockData.trainingPlans.where((p) {
      final sportMatch = _selectedSport == 'All' || p.sport == _selectedSport;
      final diffMatch = _selectedDifficulty == 'All' || p.difficulty == _selectedDifficulty;
      return sportMatch && diffMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 24 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Training Plans',
              style: TextStyle(
                  fontSize: isMobile ? 24 : 36,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Expert-crafted plans to help you reach your peak performance.',
              style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 32),
          _buildFilterSection(isDark),
          const SizedBox(height: 32),
          if (plans.isEmpty)
            _buildEmptyState(isDark)
          else
            Wrap(
              spacing: isMobile ? 12 : 32,
              runSpacing: isMobile ? 12 : 32,
              children: plans
                  .map((plan) => SizedBox(
                        width: isMobile ? double.infinity : 350,
                        child: GestureDetector(
                          onTap: () => context.go('/training/${plan.id}'),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? WebColors.darkCard : WebColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: isDark ? WebColors.darkBorder : WebColors.grey100),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24),
                                  decoration: const BoxDecoration(
                                    gradient: WebColors.primaryGradient,
                                    borderRadius:
                                        BorderRadius.vertical(top: Radius.circular(16)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(plan.sport,
                                          style: const TextStyle(
                                              color: WebColors.white70,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text(plan.title,
                                          style: const TextStyle(
                                              color: WebColors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text('by ${plan.coachName}',
                                          style: const TextStyle(
                                              color: WebColors.white70, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(plan.description,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: isDark
                                                  ? WebColors.darkTextSecondary
                                                  : WebColors.textSecondary)),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          _Chip(label: plan.difficulty, isDark: isDark),
                                          const SizedBox(width: 8),
                                          _Chip(
                                              label: '${plan.durationWeeks} weeks',
                                              isDark: isDark),
                                          const SizedBox(width: 8),
                                          _Chip(
                                              label: '★ ${plan.rating}', isDark: isDark),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      ...plan.features.map((f) => Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.check_circle,
                                                    size: 16, color: WebColors.accent),
                                                const SizedBox(width: 8),
                                                Text(f,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: isDark
                                                            ? WebColors.darkTextSecondary
                                                            : WebColors.grey700)),
                                              ],
                                            ),
                                          )),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('₹${plan.price}',
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: WebColors.primary)),
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: WebColors.primaryGradient,
                                                borderRadius: BorderRadius.circular(8)),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(8),
                                                onTap: () => context
                                                    .go('/training/${plan.id}'),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20, vertical: 10),
                                                  child: Text('Enroll Now',
                                                      style: TextStyle(
                                                          color: WebColors.white,
                                                          fontWeight: FontWeight.w600)),
                                                ),
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
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sport',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sports.map((sport) {
            final selected = _selectedSport == sport;
            return ChoiceChip(
              label: Text(sport),
              selected: selected,
              onSelected: (_) => setState(() => _selectedSport = sport),
              selectedColor: WebColors.primary,
              backgroundColor:
                  isDark ? WebColors.darkBorder : WebColors.grey100,
              labelStyle: TextStyle(
                  color: selected
                      ? WebColors.white
                      : (isDark ? WebColors.darkTextSecondary : WebColors.grey700),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text('Difficulty',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _difficulties.map((diff) {
            final selected = _selectedDifficulty == diff;
            return ChoiceChip(
              label: Text(diff),
              selected: selected,
              onSelected: (_) => setState(() => _selectedDifficulty = diff),
              selectedColor: WebColors.primary,
              backgroundColor:
                  isDark ? WebColors.darkBorder : WebColors.grey100,
              labelStyle: TextStyle(
                  color: selected
                      ? WebColors.white
                      : (isDark ? WebColors.darkTextSecondary : WebColors.grey700),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            Icon(Icons.search_off,
                size: 64,
                color: isDark ? WebColors.darkTextHint : WebColors.grey400),
            const SizedBox(height: 16),
            Text('No plans found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Try adjusting your filters to see more results.',
                style: TextStyle(
                    fontSize: 14,
                    color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isDark;
  const _Chip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkBorder : WebColors.grey100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              color: isDark ? WebColors.darkTextSecondary : WebColors.grey700)),
    );
  }
}
