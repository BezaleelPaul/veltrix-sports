import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebCoachDetailScreen extends ConsumerWidget {
  final String id;
  const WebCoachDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final coach = MockData.coaches.firstWhere(
      (c) => c.id == id,
      orElse: () => MockData.coaches.first,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 48),
            decoration: BoxDecoration(
              gradient: WebColors.primaryGradient,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back, color: WebColors.white),
                          SizedBox(width: 8),
                          Text('Back', style: TextStyle(color: WebColors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: isMobile ? 28 : 40,
                          backgroundColor: WebColors.white.withValues(alpha: 0.2),
                          child: Text(
                            coach.name.split(' ').last[0],
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: WebColors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(coach.name, style: TextStyle(color: WebColors.white, fontSize: isMobile ? 20 : 28, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _HeaderChip(label: coach.sport),
                                  const SizedBox(width: 8),
                                  _HeaderChip(label: '${coach.yearsExperience} yrs exp'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 6),
                        Text('${coach.rating}', style: const TextStyle(color: WebColors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(width: 6),
                        Text('(${coach.totalReviews} reviews)', style: const TextStyle(color: WebColors.white70, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: coach.isAvailable ? WebColors.accent.withValues(alpha: 0.2) : WebColors.error.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        coach.isAvailable ? 'Available' : 'Currently Unavailable',
                        style: TextStyle(
                          color: coach.isAvailable ? WebColors.accent : WebColors.error,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: isDark ? WebColors.darkBackground : WebColors.grey50,
            padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 12),
                      Text(coach.bio, style: TextStyle(fontSize: 16, height: 1.6, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                      const SizedBox(height: 40),
                      Text('Specializations', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: coach.specializations.map((s) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: WebColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(s, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: WebColors.primary)),
                            )).toList(),
                      ),
                      const SizedBox(height: 40),
                      Text('Session Price', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 12),
                      Text('₹${coach.sessionPrice} / session', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: WebColors.primary)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? WebColors.darkSurface : WebColors.white,
              border: Border(top: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: coach.isAvailable ? WebColors.primaryGradient : null,
                    color: coach.isAvailable ? null : WebColors.grey300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: coach.isAvailable ? () {} : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            coach.isAvailable ? 'Book Session' : 'Unavailable',
                            style: TextStyle(color: coach.isAvailable ? WebColors.white : WebColors.grey500, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final String label;
  const _HeaderChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: WebColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: WebColors.white, fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}
