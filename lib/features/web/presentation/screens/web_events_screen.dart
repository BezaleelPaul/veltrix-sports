import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebEventsScreen extends ConsumerStatefulWidget {
  const WebEventsScreen({super.key});

  @override
  ConsumerState<WebEventsScreen> createState() => _WebEventsScreenState();
}

class _WebEventsScreenState extends ConsumerState<WebEventsScreen> {
  String _selectedSport = 'All';

  static const _sports = ['All', 'Running', 'Cycling', 'Triathlon', 'Swimming'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final events = MockData.events.where((e) {
      return _selectedSport == 'All' || e.sport == _selectedSport;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 24 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events',
              style: TextStyle(
                  fontSize: isMobile ? 24 : 36,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Discover and register for exciting sports events.',
              style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 32),
          _buildFilterSection(isDark),
          const SizedBox(height: 32),
          if (events.isEmpty)
            _buildEmptyState(isDark)
          else
            Wrap(
              spacing: isMobile ? 12 : 32,
              runSpacing: isMobile ? 12 : 32,
              children: events
                  .map((event) {
                    final spotsLeft = event.maxParticipants - event.currentParticipants;
                    final capacityRatio =
                        event.currentParticipants / event.maxParticipants;
                    return SizedBox(
                      width: isMobile ? double.infinity : 350,
                      child: GestureDetector(
                        onTap: () => context.go('/events/${event.id}'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark ? WebColors.darkCard : WebColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: isDark ? WebColors.darkBorder : WebColors.grey100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: WebColors.secondary.withValues(alpha: 0.1),
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(event.sport,
                                        style: const TextStyle(
                                            color: WebColors.secondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(event.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? WebColors.darkTextPrimary
                                                : WebColors.textPrimary)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(event.description,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: isDark
                                                ? WebColors.darkTextSecondary
                                                : WebColors.textSecondary)),
                                    const SizedBox(height: 16),
                                    _InfoRow(
                                        icon: Icons.location_on_outlined,
                                        text: '${event.location}, ${event.city}',
                                        isDark: isDark),
                                    const SizedBox(height: 8),
                                    _InfoRow(
                                        icon: Icons.calendar_today,
                                        text: DateFormat('MMM dd, yyyy')
                                            .format(event.eventDate),
                                        isDark: isDark),
                                    const SizedBox(height: 8),
                                    _InfoRow(
                                        icon: Icons.people_outline,
                                        text:
                                            '${event.currentParticipants}/${event.maxParticipants} registered',
                                        isDark: isDark),
                                    const SizedBox(height: 8),
                                    _InfoRow(
                                        icon: Icons.star_outline,
                                        text: '${event.rating} rating',
                                        isDark: isDark),
                                    const SizedBox(height: 16),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: capacityRatio,
                                        backgroundColor:
                                            isDark ? WebColors.darkBorder : WebColors.grey200,
                                        valueColor:
                                            const AlwaysStoppedAnimation(WebColors.primary),
                                        minHeight: 6,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${spotsLeft} spots left',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: spotsLeft < 100
                                                ? WebColors.error
                                                : (isDark
                                                    ? WebColors.darkTextSecondary
                                                    : WebColors.grey600),
                                          ),
                                        ),
                                        Text('${capacityRatio.toStringAsFixed(0)}% filled',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: isDark
                                                    ? WebColors.darkTextHint
                                                    : WebColors.grey500)),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('₹${event.registrationFee}',
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: WebColors.primary)),
                                        Container(
                                          decoration: BoxDecoration(
                                              gradient: WebColors.primaryGradient,
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(8),
                                              onTap: () =>
                                                  context.go('/events/${event.id}'),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                child: Text('Register',
                                                    style: TextStyle(
                                                        color: WebColors.white,
                                                        fontWeight: FontWeight.w600)),
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
                      ),
                    );
                  })
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sport',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sports.map((sport) {
            final selected = _selectedSport == sport;
            return ChoiceChip(
              label: Text(sport),
              selected: selected,
              onSelected: (_) => setState(() => _selectedSport = sport),
              selectedColor: WebColors.primary,
              backgroundColor:
                  isDark ? WebColors.darkBorder : WebColors.grey100,
              labelStyle: TextStyle(
                  color: selected
                      ? WebColors.white
                      : (isDark ? WebColors.darkTextSecondary : WebColors.grey700),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            Icon(Icons.event_busy,
                size: 64,
                color: isDark ? WebColors.darkTextHint : WebColors.grey400),
            const SizedBox(height: 16),
            Text('No events found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Try selecting a different sport to see available events.',
                style: TextStyle(
                    fontSize: 14,
                    color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;
  const _InfoRow({required this.icon, required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isDark ? WebColors.darkTextHint : WebColors.grey500),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 13,
                    color: isDark ? WebColors.darkTextSecondary : WebColors.grey700))),
      ],
    );
  }
}
