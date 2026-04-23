import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
    this.backgroundColor,
    this.textColor,
  });

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '\৳ ${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: textColor ?? Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                String formattedAmount = _formatAmount(amount);
                double fontSize = 13;

                if (formattedAmount.length > 15) {
                  fontSize = 11;
                } else if (formattedAmount.length > 12) {
                  fontSize = 12;
                } else if (formattedAmount.length > 10) {
                  fontSize = 13;
                } else {
                  fontSize = 14;
                }

                return Text(
                  formattedAmount,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: textColor ?? Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
