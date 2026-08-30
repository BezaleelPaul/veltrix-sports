import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebCoachesScreen extends ConsumerStatefulWidget {
  const WebCoachesScreen({super.key});

  @override
  ConsumerState<WebCoachesScreen> createState() => _WebCoachesScreenState();
}

class _WebCoachesScreenState extends ConsumerState<WebCoachesScreen> {
  String _selectedSport = 'All';

  static const _sports = ['All', 'Running', 'Swimming', 'Cycling', 'Triathlon', 'Fitness'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final coaches = MockData.coaches.where((c) {
      return _selectedSport == 'All' || c.sport == _selectedSport;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 24 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Expert Coaches',
              style: TextStyle(
                  fontSize: isMobile ? 24 : 36,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Connect with certified coaches to accelerate your athletic journey.',
              style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 32),
          _buildFilterSection(isDark),
          const SizedBox(height: 32),
          if (coaches.isEmpty)
            _buildEmptyState(isDark)
          else
            Wrap(
              spacing: isMobile ? 12 : 32,
              runSpacing: isMobile ? 12 : 32,
              children: coaches
                  .map((coach) => SizedBox(
                        width: isMobile ? double.infinity : 300,
                        child: GestureDetector(
                          onTap: () => context.go('/coaches/${coach.id}'),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark ? WebColors.darkCard : WebColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: isDark ? WebColors.darkBorder : WebColors.grey100),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundColor:
                                          WebColors.primary.withValues(alpha: 0.1),
                                      child: Text(coach.name.split(' ').last[0],
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: WebColors.primary)),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(coach.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDark
                                                      ? WebColors.darkTextPrimary
                                                      : WebColors.textPrimary)),
                                          Text(coach.sport,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: isDark
                                                      ? WebColors.darkTextSecondary
                                                      : WebColors.grey500)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(coach.bio,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: isDark
                                            ? WebColors.darkTextSecondary
                                            : WebColors.textSecondary)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text('${coach.rating}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: WebColors.primary)),
                                    const SizedBox(width: 4),
                                    Text('(${coach.totalReviews} reviews)',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: isDark
                                                ? WebColors.darkTextHint
                                                : WebColors.grey500)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text('${coach.yearsExperience} years experience',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark
                                            ? WebColors.darkTextHint
                                            : WebColors.grey500)),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: coach.specializations
                                      .map((s) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: WebColors.primary.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(s,
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: WebColors.primary)),
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Per Session',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: isDark
                                                    ? WebColors.darkTextHint
                                                    : WebColors.grey500)),
                                        Text('₹${coach.sessionPrice}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: WebColors.primary)),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: coach.isAvailable
                                            ? WebColors.primaryGradient
                                            : null,
                                        color: coach.isAvailable ? null : WebColors.grey300,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(8),
                                          onTap: coach.isAvailable
                                              ? () => context.go('/coaches/${coach.id}')
                                              : null,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Text(
                                              coach.isAvailable ? 'Book Now' : 'Unavailable',
                                              style: TextStyle(
                                                  color: coach.isAvailable
                                                      ? WebColors.white
                                                      : WebColors.grey500,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
      ],
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            Icon(Icons.person_off,
                size: 64,
                color: isDark ? WebColors.darkTextHint : WebColors.grey400),
            const SizedBox(height: 16),
            Text('No coaches found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Try selecting a different sport to see available coaches.',
                style: TextStyle(
                    fontSize: 14,
                    color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
