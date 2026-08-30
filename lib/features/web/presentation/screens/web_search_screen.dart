import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebSearchScreen extends ConsumerStatefulWidget {
  const WebSearchScreen({super.key});

  @override
  ConsumerState<WebSearchScreen> createState() => _WebSearchScreenState();
}

class _WebSearchScreenState extends ConsumerState<WebSearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    final plans = MockData.trainingPlans.where((p) =>
        p.title.toLowerCase().contains(_query.toLowerCase()) ||
        p.sport.toLowerCase().contains(_query.toLowerCase()) ||
        p.coachName.toLowerCase().contains(_query.toLowerCase())).toList();

    final events = MockData.events.where((e) =>
        e.name.toLowerCase().contains(_query.toLowerCase()) ||
        e.sport.toLowerCase().contains(_query.toLowerCase()) ||
        e.city.toLowerCase().contains(_query.toLowerCase())).toList();

    final coaches = MockData.coaches.where((c) =>
        c.name.toLowerCase().contains(_query.toLowerCase()) ||
        c.sport.toLowerCase().contains(_query.toLowerCase())).toList();

    final hasResults = plans.isNotEmpty || events.isNotEmpty || coaches.isNotEmpty;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                autofocus: true,
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search training plans, events, coaches...',
                  hintStyle: TextStyle(color: isDark ? WebColors.darkTextHint : WebColors.grey400),
                  prefixIcon: Icon(Icons.search, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark ? WebColors.darkCard : WebColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: WebColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_query.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Column(
                      children: [
                        Icon(Icons.search, size: 64, color: isDark ? WebColors.darkTextHint : WebColors.grey300),
                        const SizedBox(height: 16),
                        Text(
                          'Start typing to search',
                          style: TextStyle(fontSize: 16, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                        ),
                      ],
                    ),
                  ),
                )
              else if (!hasResults)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 64, color: isDark ? WebColors.darkTextHint : WebColors.grey300),
                        const SizedBox(height: 16),
                        Text(
                          'No results found for "$_query"',
                          style: TextStyle(fontSize: 16, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                if (plans.isNotEmpty) ...[
                  _sectionHeader('Training Plans', isDark),
                  const SizedBox(height: 8),
                  ...plans.map((p) => _ResultTile(
                    title: p.title,
                    subtitle: '${p.sport} · ${p.coachName}',
                    onTap: () => context.go('/training/${p.id}'),
                    isDark: isDark,
                  )),
                  const SizedBox(height: 16),
                ],
                if (events.isNotEmpty) ...[
                  _sectionHeader('Events', isDark),
                  const SizedBox(height: 8),
                  ...events.map((e) => _ResultTile(
                    title: e.name,
                    subtitle: '${e.sport} · ${e.city}',
                    onTap: () => context.go('/events/${e.id}'),
                    isDark: isDark,
                  )),
                  const SizedBox(height: 16),
                ],
                if (coaches.isNotEmpty) ...[
                  _sectionHeader('Coaches', isDark),
                  const SizedBox(height: 8),
                  ...coaches.map((c) => _ResultTile(
                    title: c.name,
                    subtitle: '${c.sport} · ${c.yearsExperience} yrs exp',
                    onTap: () => context.go('/coaches/${c.id}'),
                    isDark: isDark,
                  )),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? WebColors.darkTextSecondary : WebColors.grey600,
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  const _ResultTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkCard : WebColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
        subtitle: Text(subtitle, style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
        trailing: Icon(Icons.chevron_right, color: isDark ? WebColors.darkTextHint : WebColors.grey400),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
