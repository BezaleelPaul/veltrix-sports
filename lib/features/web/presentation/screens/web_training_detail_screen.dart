import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebTrainingDetailScreen extends ConsumerWidget {
  final String id;
  const WebTrainingDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final plan = MockData.trainingPlans.firstWhere(
      (p) => p.id == id,
      orElse: () => MockData.trainingPlans.first,
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
                    Icon(
                      Icons.fitness_center,
                      size: 48,
                      color: WebColors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 16),
                    Text(plan.title, style: TextStyle(color: WebColors.white, fontSize: isMobile ? 22 : 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('by ${plan.coachName}', style: const TextStyle(color: WebColors.white70, fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _DetailChip(label: plan.sport),
                        const SizedBox(width: 8),
                        _DetailChip(label: plan.difficulty),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 6),
                        Text('${plan.rating}', style: const TextStyle(color: WebColors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(width: 6),
                        Text('(${plan.totalReviews} reviews)', style: const TextStyle(color: WebColors.white70, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('₹${plan.price}', style: TextStyle(color: WebColors.white, fontSize: isMobile ? 26 : 36, fontWeight: FontWeight.bold)),
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
                      Text(plan.description, style: TextStyle(fontSize: 16, height: 1.6, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                      const SizedBox(height: 40),
                      Text('Features', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 16),
                      ...plan.features.map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, size: 20, color: WebColors.accent),
                                const SizedBox(width: 12),
                                Expanded(child: Text(f, style: TextStyle(fontSize: 15, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700))),
                              ],
                            ),
                          )),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text('Coach: ', style: TextStyle(fontSize: 18, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                          Text(plan.coachName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WebColors.primary)),
                        ],
                      ),
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
                  decoration: BoxDecoration(gradient: WebColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text('Enroll Now', style: TextStyle(color: WebColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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

class _DetailChip extends StatelessWidget {
  final String label;
  const _DetailChip({required this.label});

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
