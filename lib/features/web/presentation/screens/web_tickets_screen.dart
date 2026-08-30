import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebTicketsScreen extends ConsumerWidget {
  const WebTicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final tickets = MockData.tickets;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Tickets',
              style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Manage your event tickets and registrations.',
              style: TextStyle(
                  color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? WebColors.darkCard : WebColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isDark ? WebColors.darkBorder : WebColors.grey100),
            ),
            child: isMobile
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        _header('Event', isDark),
                        _header('Category', isDark),
                        _header('Date', isDark),
                        _header('Seat/Bib', isDark),
                        _header('Price', isDark),
                        _header('Status', isDark),
                        _header('Action', isDark),
                      ],
              rows: tickets
                  .map((ticket) => DataRow(cells: [
                        DataCell(Text(ticket.eventName,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? WebColors.darkTextPrimary
                                    : WebColors.textPrimary))),
                        DataCell(Text(ticket.category,
                            style: TextStyle(
                                color: isDark
                                    ? WebColors.darkTextSecondary
                                    : WebColors.grey700))),
                        DataCell(Text(
                            DateFormat('MMM dd, yyyy').format(ticket.eventDate),
                            style: TextStyle(
                                color: isDark
                                    ? WebColors.darkTextSecondary
                                    : WebColors.grey700))),
                        DataCell(Text(ticket.seatInfo,
                            style: TextStyle(
                                color: isDark
                                    ? WebColors.darkTextSecondary
                                    : WebColors.grey700))),
                        DataCell(Text('₹${ticket.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: WebColors.primary))),
                        DataCell(_StatusBadge(status: ticket.status)),
                        DataCell(
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    gradient: WebColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () => context
                                        .go('/dashboard/tickets/${ticket.id}'),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Text('View QR',
                                          style: TextStyle(
                                              color: WebColors.white,
                                              fontSize: 12)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))
                  .toList(),
                    ),
                  )
                : DataTable(
                    columns: [
                      _header('Event', isDark),
                      _header('Category', isDark),
                      _header('Date', isDark),
                      _header('Seat/Bib', isDark),
                      _header('Price', isDark),
                      _header('Status', isDark),
                      _header('Action', isDark),
                    ],
                    rows: tickets
                        .map((ticket) => DataRow(cells: [
                              DataCell(Text(ticket.eventName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? WebColors.darkTextPrimary
                                          : WebColors.textPrimary))),
                              DataCell(Text(ticket.category,
                                  style: TextStyle(
                                      color: isDark
                                          ? WebColors.darkTextSecondary
                                          : WebColors.grey700))),
                              DataCell(Text(
                                  DateFormat('MMM dd, yyyy').format(ticket.eventDate),
                                  style: TextStyle(
                                      color: isDark
                                          ? WebColors.darkTextSecondary
                                          : WebColors.grey700))),
                              DataCell(Text(ticket.seatInfo,
                                  style: TextStyle(
                                      color: isDark
                                          ? WebColors.darkTextSecondary
                                          : WebColors.grey700))),
                              DataCell(Text('₹${ticket.price}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: WebColors.primary))),
                              DataCell(_StatusBadge(status: ticket.status)),
                              DataCell(
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: WebColors.primaryGradient,
                                          borderRadius: BorderRadius.circular(6)),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () => context
                                              .go('/dashboard/tickets/${ticket.id}'),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            child: Text('View QR',
                                                style: TextStyle(
                                                    color: WebColors.white,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]))
                        .toList(),
                  ),
            ),
        ],
      ),
    );
  }

  DataColumn _header(String text, bool isDark) {
    return DataColumn(
      label: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? WebColors.darkTextSecondary : WebColors.grey600)),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    switch (status) {
      case 'active':
        bgColor = WebColors.accent.withValues(alpha: 0.1);
        textColor = WebColors.accent;
        break;
      case 'used':
        bgColor = WebColors.grey200;
        textColor = WebColors.grey600;
        break;
      case 'cancelled':
        bgColor = WebColors.error.withValues(alpha: 0.1);
        textColor = WebColors.error;
        break;
      default:
        bgColor = WebColors.grey100;
        textColor = WebColors.grey600;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }
}
