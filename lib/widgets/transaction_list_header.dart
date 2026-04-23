import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class TransactionListHeader extends StatelessWidget {
  final int transactionCount;

  const TransactionListHeader({super.key, required this.transactionCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppConstants.deepBlue, AppConstants.brightBlue],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants.deepBlue.withOpacity(0.1),
                  AppConstants.brightBlue.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppConstants.brightBlue.withOpacity(0.3),
              ),
            ),
            child: Text(
              '$transactionCount Total',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppConstants.deepBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
