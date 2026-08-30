import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/mock/mock_data.dart';

class WebTrainingScreen extends StatelessWidget {
  const WebTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            color: WebColors.grey50,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Training Plans', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      const Text('Expert-designed plans for every level.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildFilterChip('All', true),
                          const SizedBox(width: 8),
                          _buildFilterChip('Running', false),
                          const SizedBox(width: 8),
                          _buildFilterChip('Cycling', false),
                          const SizedBox(width: 8),
                          _buildFilterChip('Triathlon', false),
                          const SizedBox(width: 8),
                          _buildFilterChip('Nutrition', false),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Plans Grid
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.85,
              ),
              itemCount: MockData.trainingPlans.length,
              itemBuilder: (context, index) {
                final plan = MockData.trainingPlans[index];
                return _buildPlanCard(plan);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? WebColors.primary : WebColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? WebColors.primary : WebColors.grey300),
      ),
      child: Text(label, style: TextStyle(color: selected ? WebColors.white : WebColors.textPrimary, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildPlanCard(dynamic plan) {
    return Container(
      decoration: BoxDecoration(
        color: WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: WebColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(child: Icon(Icons.fitness_center, size: 48, color: WebColors.primary)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(plan.coachName, style: const TextStyle(color: WebColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: WebColors.accent, size: 16),
                    const SizedBox(width: 4),
                    Text('${plan.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text('${plan.totalStudents} students', style: const TextStyle(color: WebColors.textSecondary, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip('${plan.durationWeeks} weeks'),
                    const SizedBox(width: 8),
                    _buildInfoChip(plan.level),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${plan.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: WebColors.primary)),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: const Text('Start Plan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: WebColors.grey100, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: const TextStyle(fontSize: 12, color: WebColors.textSecondary)),
    );
  }
}
