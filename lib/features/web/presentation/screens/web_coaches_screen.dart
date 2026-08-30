import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebCoachesScreen extends ConsumerWidget {
  const WebCoachesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);
    final coaches = MockData.coaches;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Expert Coaches', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Connect with certified coaches to accelerate your athletic journey.',
              style: TextStyle(fontSize: 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            children: coaches.map((coach) => SizedBox(
              width: 300,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: WebColors.primary.withOpacity(0.1),
                          child: Text(coach.name.split(' ').last[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.primary)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(coach.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                              Text(coach.sport, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(coach.bio, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text('${coach.rating}', style: const TextStyle(fontWeight: FontWeight.w600, color: WebColors.primary)),
                        const SizedBox(width: 4),
                        Text('(${coach.totalReviews} reviews)', style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${coach.yearsExperience} years experience',
                        style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: coach.specializations.map((s) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: WebColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(s, style: const TextStyle(fontSize: 11, color: WebColors.primary)),
                      )).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Per Session', style: TextStyle(fontSize: 11, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                            Text('₹${coach.sessionPrice}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: WebColors.primary)),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: coach.isAvailable ? WebColors.primaryGradient : null,
                            color: coach.isAvailable ? null : WebColors.grey300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: coach.isAvailable ? () {} : null,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  coach.isAvailable ? 'Book Now' : 'Unavailable',
                                  style: TextStyle(color: coach.isAvailable ? WebColors.white : WebColors.grey500, fontWeight: FontWeight.w600),
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
            )).toList(),
          ),
        ],
      ),
    );
  }
}
