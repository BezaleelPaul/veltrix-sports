import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/mock/mock_data.dart';

class WebCoachesScreen extends StatelessWidget {
  const WebCoachesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            color: WebColors.grey50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Expert Coaches', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Connect with certified coaches for personalized training.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 0.85),
              itemCount: MockData.coaches.length,
              itemBuilder: (context, index) {
                final coach = MockData.coaches[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: WebColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: WebColors.grey200)),
                  child: Column(
                    children: [
                      CircleAvatar(radius: 40, backgroundColor: WebColors.primary.withOpacity(0.1), child: const Icon(Icons.person, size: 40, color: WebColors.primary)),
                      const SizedBox(height: 16),
                      Text(coach.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(coach.sport, style: const TextStyle(color: WebColors.textSecondary)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: WebColors.accent, size: 16),
                          const SizedBox(width: 4),
                          Text('${coach.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text('${coach.totalReviews} reviews', style: const TextStyle(color: WebColors.textSecondary, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('${coach.yearsExperience} years experience', style: const TextStyle(color: WebColors.textSecondary, fontSize: 13)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.center,
                        children: coach.specializations.take(3).map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: WebColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text(s, style: const TextStyle(fontSize: 11, color: WebColors.primary)),
                        )).toList(),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              child: const Text('Message'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              child: const Text('Book'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
