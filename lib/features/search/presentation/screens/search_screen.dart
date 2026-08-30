import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/training_provider.dart';
import '../../../../core/providers/event_provider.dart';
import '../../../../core/providers/coach_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final training = ref.watch(trainingPlansProvider).valueOrNull ?? [];
    final events = ref.watch(eventsProvider).valueOrNull ?? [];
    final coaches = ref.watch(coachesProvider).valueOrNull ?? [];

    final filteredTraining = _query.isEmpty ? [] : training.where((p) => p.title.toLowerCase().contains(_query.toLowerCase()) || p.sport.toLowerCase().contains(_query.toLowerCase())).toList();
    final filteredEvents = _query.isEmpty ? [] : events.where((e) => e.name.toLowerCase().contains(_query.toLowerCase()) || e.sport.toLowerCase().contains(_query.toLowerCase())).toList();
    final filteredCoaches = _query.isEmpty ? [] : coaches.where((c) => c.name.toLowerCase().contains(_query.toLowerCase()) || c.sport.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search training, events, coaches...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: AppColors.card,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: _query.isEmpty
                  ? Center(child: Text('Start typing to search', style: TextStyle(color: AppColors.textSecondary)))
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        if (filteredTraining.isNotEmpty) ...[
                          Text('Training Plans', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          ...filteredTraining.map((p) => ListTile(
                            title: Text(p.title),
                            subtitle: Text('${p.sport} · ${p.coachName}'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => context.push('/training/${p.id}'),
                          )),
                        ],
                        if (filteredEvents.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text('Events', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          ...filteredEvents.map((e) => ListTile(
                            title: Text(e.name),
                            subtitle: Text('${e.sport} · ${e.city}'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => context.push('/events/${e.id}'),
                          )),
                        ],
                        if (filteredCoaches.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text('Coaches', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          ...filteredCoaches.map((c) => ListTile(
                            title: Text(c.name),
                            subtitle: Text(c.sport),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => context.push('/coaches/${c.id}'),
                          )),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
