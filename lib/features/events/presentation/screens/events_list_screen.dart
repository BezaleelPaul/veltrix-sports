import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/event_provider.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);
    final selectedSport = ref.watch(selectedEventSportFilterProvider);
    final sports = ['All', 'Running', 'Cycling', 'Triathlon', 'Swimming'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Events', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sports.length,
                itemBuilder: (context, i) {
                  final sport = sports[i];
                  final isSelected = (selectedSport == null && sport == 'All') || selectedSport == sport;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(sport),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(selectedEventSportFilterProvider.notifier).state = sport == 'All' ? null : sport;
                      },
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: eventsAsync.when(
                data: (events) {
                  final filtered = selectedSport != null
                      ? events.where((e) => e.sport == selectedSport).toList()
                      : events;
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => _buildEventCard(context, filtered[i]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, dynamic event) {
    final spotsLeft = event.maxParticipants - event.currentParticipants;
    return GestureDetector(
      onTap: () => context.push('/events/${event.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(event.sport, style: TextStyle(color: AppColors.primary, fontSize: 12)),
                ),
                const Spacer(),
                Icon(Icons.star, size: 14, color: AppColors.warning),
                const SizedBox(width: 4),
                Text('${event.rating}', style: TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 12),
            Text(event.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text(event.location, style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const Spacer(),
                Text('₹${event.registrationFee.toInt()}', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: event.currentParticipants / event.maxParticipants,
              backgroundColor: AppColors.grey200,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
            const SizedBox(height: 4),
            Text('$spotsLeft spots left', style: TextStyle(color: spotsLeft < 100 ? Colors.red : AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
