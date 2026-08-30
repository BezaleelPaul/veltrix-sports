import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebTrainingScreen extends ConsumerWidget {
  const WebTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);
    final plans = MockData.trainingPlans;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Training Plans', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Expert-crafted plans to help you reach your peak performance.',
              style: TextStyle(fontSize: 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            children: plans.map((plan) => SizedBox(
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: WebColors.primaryGradient,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plan.sport, style: const TextStyle(color: WebColors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text(plan.title, style: const TextStyle(color: WebColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('by ${plan.coachName}', style: const TextStyle(color: WebColors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plan.description,
                              style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _Chip(label: plan.difficulty, isDark: isDark),
                              const SizedBox(width: 8),
                              _Chip(label: '${plan.durationWeeks} weeks', isDark: isDark),
                              const SizedBox(width: 8),
                              _Chip(label: '★ ${plan.rating}', isDark: isDark),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...plan.features.map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, size: 16, color: WebColors.accent),
                                const SizedBox(width: 8),
                                Text(f, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700)),
                              ],
                            ),
                          )),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹${plan.price}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.primary)),
                              Container(
                                decoration: BoxDecoration(gradient: WebColors.primaryGradient, borderRadius: BorderRadius.circular(8)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Text('Enroll Now', style: TextStyle(color: WebColors.white, fontWeight: FontWeight.w600)),
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
            )).toList(),
          ),
        ],
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
      child: Text(label, style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700)),
    );
  }
}
