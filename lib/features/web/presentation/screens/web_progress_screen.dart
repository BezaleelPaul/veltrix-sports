import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebProgressScreen extends ConsumerWidget {
  const WebProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    final stats = [
      _StatItem(Icons.fitness_center, 'Total Workouts', '48', WebColors.primary),
      _StatItem(Icons.timer_outlined, 'Hours Trained', '124', WebColors.accent),
      _StatItem(Icons.local_fire_department, 'Streak', '12 days', WebColors.secondary),
    ];

    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final weekValues = [6, 8, 5, 9, 7, 10, 4];
    final maxVal = weekValues.reduce((a, b) => a > b ? a : b);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Progress',
                style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              isMobile
                  ? Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: stats.map((s) => SizedBox(
                        width: (screenWidth - 64) / 2 > 200 ? 200 : (screenWidth - 64) / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark ? WebColors.darkCard : WebColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                            ),
                            child: Column(
                              children: [
                                Icon(s.icon, color: s.color, size: 28),
                                const SizedBox(height: 12),
                                Text(
                                  s.value,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.label,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? WebColors.darkTextSecondary : WebColors.grey500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )).toList(),
                    )
                  : Row(
                      children: stats.map((s) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark ? WebColors.darkCard : WebColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                            ),
                            child: Column(
                              children: [
                                Icon(s.icon, color: s.color, size: 28),
                                const SizedBox(height: 12),
                                Text(
                                  s.value,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.label,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? WebColors.darkTextSecondary : WebColors.grey500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(7, (i) {
                          final barHeight = (weekValues[i] / maxVal) * 160.0;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${weekValues[i]}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? WebColors.darkTextSecondary : WebColors.grey600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: barHeight,
                                    decoration: BoxDecoration(
                                      gradient: WebColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    weekDays[i],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? WebColors.darkTextSecondary : WebColors.grey600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatItem(this.icon, this.label, this.value, this.color);
}
