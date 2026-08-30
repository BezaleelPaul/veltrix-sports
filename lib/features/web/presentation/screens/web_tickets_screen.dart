import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/mock/mock_data.dart';

class WebTicketsScreen extends StatelessWidget {
  const WebTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Tickets', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          // Table
          Container(
            decoration: BoxDecoration(
              color: WebColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: WebColors.grey200),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    color: WebColors.grey50,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 2, child: Text('Event', style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Category', style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                // Rows
                ...MockData.tickets.map((ticket) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: WebColors.grey100))),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(ticket.eventName, style: const TextStyle(fontWeight: FontWeight.w500))),
                      Expanded(child: Text(ticket.category)),
                      Expanded(child: Text('${ticket.eventDate.day}/${ticket.eventDate.month}/${ticket.eventDate.year}')),
                      Expanded(child: Text('₹${ticket.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, color: WebColors.primary))),
                      Expanded(child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: WebColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text(ticket.status, style: const TextStyle(color: WebColors.secondary, fontSize: 13, fontWeight: FontWeight.w600)),
                      )),
                      Expanded(child: Row(children: [
                        IconButton(icon: const Icon(Icons.qr_code, size: 18), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.download, size: 18), onPressed: () {}),
                      ])),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
