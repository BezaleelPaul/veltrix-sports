import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/training_provider.dart';
import '../../../../core/providers/event_provider.dart';
import '../../../../core/mock/mock_data.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    final trainingAsync = ref.watch(trainingPlansProvider);
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            (user?.name ?? 'A')[0],
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello, ${user?.name ?? 'Athlete'}', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('What are you training for today?', style: TextStyle(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                          onPressed: () => context.push('/notifications'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildQuickActions(context),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Upcoming Events', () => context.go('/events')),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: eventsAsync.when(
                  data: (events) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: events.length,
                    itemBuilder: (context, i) => _buildEventCard(context, events[i]),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const Center(child: Text('Error loading events')),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _buildSectionHeader('Popular Training Plans', () => context.go('/training')),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: trainingAsync.when(
                  data: (plans) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: plans.length,
                    itemBuilder: (context, i) => _buildTrainingCard(context, plans[i]),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const Center(child: Text('Error')),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildQuickAction(Icons.fitness_center, 'Training', () => context.go('/training')),
        _buildQuickAction(Icons.event, 'Events', () => context.go('/events')),
        _buildQuickAction(Icons.confirmation_number, 'Tickets', () => context.go('/tickets')),
        _buildQuickAction(Icons.person, 'Coaches', () => context.go('/coaches')),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onSeeAll, child: Text('See All', style: TextStyle(color: AppColors.primary))),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, dynamic event) {
    return GestureDetector(
      onTap: () => context.push('/events/${event.id}'),
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(event.sport, style: TextStyle(color: AppColors.primary, fontSize: 12)),
              ),
              const SizedBox(height: 8),
              Text(event.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(event.location, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text('${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrainingCard(BuildContext context, dynamic plan) {
    return GestureDetector(
      onTap: () => context.push('/training/${plan.id}'),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(plan.sport, style: TextStyle(color: AppColors.accent, fontSize: 12)),
              ),
              const SizedBox(height: 8),
              Text(plan.title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(plan.coachName, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.star, size: 14, color: AppColors.warning),
                  const SizedBox(width: 4),
                  Text('${plan.rating}', style: TextStyle(fontSize: 13)),
                  const Spacer(),
                  Text('₹${plan.price.toInt()}', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
