import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/mock/mock_data.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<_SearchResult> _results = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _hasSearched = false;
      });
      return;
    }

    final allResults = <_SearchResult>[];

    // Search training plans
    for (var plan in MockData.trainingPlans) {
      if (plan.name.toLowerCase().contains(query.toLowerCase()) ||
          plan.sport.toLowerCase().contains(query.toLowerCase()) ||
          plan.coachName.toLowerCase().contains(query.toLowerCase())) {
        allResults.add(_SearchResult(
          id: plan.id,
          title: plan.name,
          subtitle: '${plan.coachName} • ${plan.durationWeeks} weeks',
          type: 'training',
          icon: Icons.fitness_center,
          price: '₹${plan.price.toStringAsFixed(0)}',
        ));
      }
    }

    // Search events
    for (var event in MockData.events) {
      if (event.name.toLowerCase().contains(query.toLowerCase()) ||
          event.sport.toLowerCase().contains(query.toLowerCase()) ||
          event.location.toLowerCase().contains(query.toLowerCase())) {
        allResults.add(_SearchResult(
          id: event.id,
          title: event.name,
          subtitle: '${event.location} • ${event.eventDate.day}/${event.eventDate.month}',
          type: 'event',
          icon: Icons.event,
          price: '₹${event.registrationFee.toStringAsFixed(0)}',
        ));
      }
    }

    // Search coaches
    for (var coach in MockData.coaches) {
      if (coach.name.toLowerCase().contains(query.toLowerCase()) ||
          coach.sport.toLowerCase().contains(query.toLowerCase())) {
        allResults.add(_SearchResult(
          id: coach.id,
          title: coach.name,
          subtitle: '${coach.sport} • ${coach.yearsExperience} years exp',
          type: 'coach',
          icon: Icons.person,
          price: '₹${coach.sessionPrice.toStringAsFixed(0)}/session',
        ));
      }
    }

    setState(() {
      _results = allResults;
      _hasSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredResults = _selectedCategory == 'All'
        ? _results
        : _results.where((r) => r.type == _selectedCategory.toLowerCase()).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search plans, events, coaches...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.grey100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
          // Category Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.white,
            child: Row(
              children: [
                _buildCategoryChip('All'),
                const SizedBox(width: 8),
                _buildCategoryChip('Training'),
                const SizedBox(width: 8),
                _buildCategoryChip('Events'),
                const SizedBox(width: 8),
                _buildCategoryChip('Coaches'),
              ],
            ),
          ),
          // Results
          Expanded(
            child: !_hasSearched
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: AppColors.grey300),
                        const SizedBox(height: 16),
                        Text(
                          'Search for anything',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : filteredResults.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: AppColors.grey300),
                            const SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredResults.length,
                        itemBuilder: (context, index) {
                          return _buildResultCard(filteredResults[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = label;
        });
      },
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.white : AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      checkmarkColor: AppColors.white,
    );
  }

  Widget _buildResultCard(_SearchResult result) {
    return GestureDetector(
      onTap: () {
        switch (result.type) {
          case 'training':
            context.push('/training/${result.id}');
            break;
          case 'event':
            context.push('/events/${result.id}');
            break;
          case 'coach':
            context.push('/coaches/${result.id}');
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(result.icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  result.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    result.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final IconData icon;
  final String price;

  _SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.icon,
    required this.price,
  });
}
