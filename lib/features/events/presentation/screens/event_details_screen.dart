import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/event_provider.dart';

class EventDetailsScreen extends ConsumerWidget {
  final String id;
  const EventDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: eventAsync.when(
        data: (event) {
          if (event == null) return const Center(child: Text('Event not found'));
          final spotsLeft = event.maxParticipants - event.currentParticipants;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(event.name, style: GoogleFonts.poppins()),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.event, size: 80, color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.calendar_today, 'Date', '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}'),
                      _buildInfoRow(Icons.location_on, 'Location', event.location),
                      _buildInfoRow(Icons.location_city, 'City', event.city),
                      _buildInfoRow(Icons.attach_money, 'Fee', '₹${event.registrationFee.toInt()}'),
                      _buildInfoRow(Icons.people, 'Spots', '$spotsLeft / ${event.maxParticipants} available'),
                      const SizedBox(height: 24),
                      Text('About', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(event.description, style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
                      const SizedBox(height: 24),
                      Text('Categories', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: event.categories.map((c) => Chip(label: Text(c), backgroundColor: AppColors.primary.withOpacity(0.1))).toList(),
                      ),
                      const SizedBox(height: 24),
                      Text('Rules', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...event.rules.map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.rule, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 8),
                            Expanded(child: Text(r, style: TextStyle(color: AppColors.textSecondary))),
                          ],
                        ),
                      )),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {},
            child: Text('Register Now', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text('$label: ', style: TextStyle(color: AppColors.textSecondary)),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
