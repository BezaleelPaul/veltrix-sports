import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebTicketDetailScreen extends ConsumerWidget {
  final String id;
  const WebTicketDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final ticket = MockData.tickets.firstWhere(
      (t) => t.id == id,
      orElse: () => MockData.tickets.first,
    );
    final isActive = ticket.status == 'active';

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 48),
            decoration: BoxDecoration(
              gradient: WebColors.primaryGradient,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back, color: WebColors.white),
                          SizedBox(width: 8),
                          Text('Back', style: TextStyle(color: WebColors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.confirmation_number, size: 40, color: WebColors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ticket.eventName, style: TextStyle(color: WebColors.white, fontSize: isMobile ? 20 : 28, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(ticket.category, style: const TextStyle(color: WebColors.white70, fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: isDark ? WebColors.darkBackground : WebColors.grey50,
            padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? WebColors.darkCard : WebColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                        ),
                        child: Column(
                          children: [
                            _DetailRow(label: 'Date', value: DateFormat('EEEE, MMM dd, yyyy').format(ticket.eventDate), isDark: isDark),
                            const SizedBox(height: 16),
                            _DetailRow(label: 'Seat / Info', value: ticket.seatInfo, isDark: isDark),
                            const SizedBox(height: 16),
                            _DetailRow(label: 'Amount', value: '₹${ticket.price}', isDark: isDark, valueColor: WebColors.primary),
                            const SizedBox(height: 16),
                            _DetailRow(
                              label: 'Status',
                              value: ticket.status[0].toUpperCase() + ticket.status.substring(1),
                              isDark: isDark,
                              valueColor: isActive ? WebColors.accent : WebColors.grey600,
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isActive ? WebColors.accent.withValues(alpha: 0.1) : WebColors.grey100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isActive ? 'Active' : (ticket.status == 'used' ? 'Used' : 'Cancelled'),
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? WebColors.accent : WebColors.grey600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _DashedDivider(color: isDark ? WebColors.darkBorder : WebColors.grey300),
                      const SizedBox(height: 32),
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: isDark ? WebColors.darkCard : WebColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_2, size: 64, color: isDark ? WebColors.darkTextSecondary : WebColors.grey400),
                            const SizedBox(height: 8),
                            Text(ticket.qrCode, style: TextStyle(fontSize: 11, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                          ],
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(height: 32),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 12,
                          children: [
                            _ActionButton(
                              icon: Icons.download,
                              label: 'Download',
                              isDark: isDark,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Ticket downloaded successfully')),
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            _ActionButton(
                              icon: Icons.swap_horiz,
                              label: 'Transfer',
                              isDark: isDark,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Transfer link copied to clipboard')),
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            _ActionButton(
                              icon: Icons.cancel_outlined,
                              label: 'Cancel',
                              isDark: isDark,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: isDark ? WebColors.darkCard : WebColors.white,
                                    title: Text('Cancel Ticket', style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                                    content: Text('Are you sure you want to cancel this ticket? This action cannot be undone.',
                                        style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: Text('Keep Ticket', style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.grey600)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Ticket cancelled')),
                                          );
                                        },
                                        child: const Text('Cancel Ticket', style: TextStyle(color: WebColors.error)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;
  final Widget? trailing;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
        const Spacer(),
        if (trailing != null) trailing! else
          Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: valueColor ?? (isDark ? WebColors.darkTextPrimary : WebColors.textPrimary))),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? WebColors.darkCard : WebColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: WebColors.primary),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WebColors.primary)),
          ],
        ),
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  final Color color;
  const _DashedDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 8.0;
        final dashSpace = 6.0;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: color,
            );
          }),
        );
      },
    );
  }
}
