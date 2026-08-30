import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/mock/mock_data.dart';

class WebDashboardScreen extends StatelessWidget {
  const WebDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(context),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, ${MockData.currentUser.name}!',
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Here\'s what\'s happening with your training.',
                            style: TextStyle(color: WebColors.textSecondary, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildIconButton(Icons.notifications_outlined),
                          const SizedBox(width: 12),
                          _buildIconButton(Icons.search),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            backgroundColor: WebColors.primary.withOpacity(0.1),
                            child: const Icon(Icons.person, color: WebColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Stats Cards
                  Row(
                    children: [
                      _buildStatCard('Active Plans', '2', Icons.fitness_center, WebColors.primary),
                      const SizedBox(width: 20),
                      _buildStatCard('Upcoming Events', '3', Icons.event, WebColors.secondary),
                      const SizedBox(width: 20),
                      _buildStatCard('My Tickets', '5', Icons.confirmation_number, WebColors.accent),
                      const SizedBox(width: 20),
                      _buildStatCard('Hours Trained', '12.5', Icons.access_time, Color(0xFF8B5CF6)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Training Progress
                      Expanded(
                        flex: 2,
                        child: _buildTrainingProgressCard(),
                      ),
                      const SizedBox(width: 24),
                      // Upcoming Events
                      Expanded(
                        child: _buildUpcomingEventsCard(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recent Activity
                      Expanded(
                        child: _buildRecentActivityCard(),
                      ),
                      const SizedBox(width: 24),
                      // Quick Actions
                      Expanded(
                        child: _buildQuickActionsCard(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 260,
      color: WebColors.grey900,
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: WebColors.primary, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.fitness_center, color: WebColors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text('Veltrix Sports', style: TextStyle(color: WebColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(color: WebColors.grey700),
          // Nav Items
          _buildNavItem(Icons.dashboard, 'Dashboard', true),
          _buildNavItem(Icons.fitness_center, 'Training', false),
          _buildNavItem(Icons.event, 'Events', false),
          _buildNavItem(Icons.confirmation_number, 'Tickets', false),
          _buildNavItem(Icons.person, 'Coaches', false),
          _buildNavItem(Icons.analytics, 'Progress', false),
          const Spacer(),
          const Divider(color: WebColors.grey700),
          _buildNavItem(Icons.settings, 'Settings', false),
          _buildNavItem(Icons.logout, 'Logout', false),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? WebColors.primary.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? WebColors.primary : WebColors.grey400, size: 20),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: isActive ? WebColors.primary : WebColors.grey400, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 44, height: 44,
      decoration: BoxDecoration(
        color: WebColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: WebColors.textSecondary),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: WebColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: WebColors.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.trending_up, color: WebColors.secondary, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: WebColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Training Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildProgressItem('Beginner Running', 'Week 2 of 4', 0.5, WebColors.primary),
          const SizedBox(height: 16),
          _buildProgressItem('Strength & Conditioning', 'Week 5 of 8', 0.625, WebColors.secondary),
          const SizedBox(height: 16),
          _buildProgressItem('Nutrition Plan', 'Week 3 of 4', 0.75, WebColors.accent),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, String subtitle, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: WebColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: progress, backgroundColor: WebColors.grey200, valueColor: AlwaysStoppedAnimation(color), minHeight: 6),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upcoming Events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          const SizedBox(height: 16),
          _buildEventItem('Mumbai Marathon', 'Sep 15', 'Mumbai'),
          _buildEventItem('Delhi Cycling', 'Oct 5', 'Delhi'),
          _buildEventItem('Bangalore Triathlon', 'Nov 20', 'Bangalore'),
        ],
      ),
    );
  }

  Widget _buildEventItem(String name, String date, String location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: WebColors.grey50, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: WebColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.event, color: WebColors.primary, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text('$date • $location', style: const TextStyle(color: WebColors.textSecondary, fontSize: 12)),
          ])),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildActivityItem('Completed Session 3', 'Beginner Running', '2h ago', WebColors.secondary),
          _buildActivityItem('Registered for Event', 'Mumbai Marathon', '1d ago', WebColors.primary),
          _buildActivityItem('Payment Confirmed', '₹500', '1d ago', WebColors.accent),
          _buildActivityItem('New Plan Started', 'Strength Training', '3d ago', Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(subtitle, style: const TextStyle(color: WebColors.textSecondary, fontSize: 12)),
          ])),
          Text(time, style: const TextStyle(color: WebColors.textLight, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WebColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildActionItem(Icons.fitness_center, 'Browse Plans', WebColors.primary),
          _buildActionItem(Icons.event, 'Find Events', WebColors.secondary),
          _buildActionItem(Icons.person, 'Find Coaches', WebColors.accent),
          _buildActionItem(Icons.confirmation_number, 'My Tickets', Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14, color: color),
        ],
      ),
    );
  }
}
