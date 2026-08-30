import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/mock/mock_data.dart';

class WebEventsScreen extends StatelessWidget {
  const WebEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            color: WebColors.grey50,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sports Events', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      const Text('Discover and register for events near you.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
                      const SizedBox(height: 24),
                      Row(children: [_buildFilterChip('All', true), const SizedBox(width: 8), _buildFilterChip('Running', false), const SizedBox(width: 8), _buildFilterChip('Cycling', false), const SizedBox(width: 8), _buildFilterChip('Triathlon', false)]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 0.8),
              itemCount: MockData.events.length,
              itemBuilder: (context, index) {
                final event = MockData.events[index];
                return Container(
                  decoration: BoxDecoration(color: WebColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: WebColors.grey200)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(color: WebColors.primary.withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
                        child: Stack(
                          children: [
                            const Center(child: Icon(Icons.event, size: 48, color: WebColors.primary)),
                            Positioned(
                              top: 12, right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: WebColors.primary, borderRadius: BorderRadius.circular(6)),
                                child: Text(event.sport, style: const TextStyle(color: WebColors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Row(children: [const Icon(Icons.calendar_today, size: 14, color: WebColors.textSecondary), const SizedBox(width: 6), Text('${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}', style: const TextStyle(color: WebColors.textSecondary, fontSize: 13))]),
                            const SizedBox(height: 4),
                            Row(children: [const Icon(Icons.location_on, size: 14, color: WebColors.textSecondary), const SizedBox(width: 6), Expanded(child: Text(event.location, style: const TextStyle(color: WebColors.textSecondary, fontSize: 13), overflow: TextOverflow.ellipsis))]),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('₹${event.registrationFee.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: WebColors.primary)),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  child: const Text('Register'),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildFilterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: selected ? WebColors.primary : WebColors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: selected ? WebColors.primary : WebColors.grey300)),
      child: Text(label, style: TextStyle(color: selected ? WebColors.white : WebColors.textPrimary, fontWeight: FontWeight.w500)),
    );
  }
}
