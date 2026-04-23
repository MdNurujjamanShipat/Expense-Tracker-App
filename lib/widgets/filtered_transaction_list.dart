import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_list_item.dart';

class FilteredTransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final int selectedFilter;
  final Function(Transaction) onDelete;

  const FilteredTransactionList({
    super.key,
    required this.transactions,
    required this.selectedFilter,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionListItem(
          transaction: transaction,
          onDelete: () => onDelete(transaction),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selectedFilter == 1
                ? Icons.trending_up_rounded
                : selectedFilter == 2
                ? Icons.trending_down_rounded
                : Icons.receipt_long_rounded,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            selectedFilter == 1
                ? 'No Income Transactions'
                : selectedFilter == 2
                ? 'No Expense Transactions'
                : 'No Transactions Yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedFilter == 1
                ? 'Add your first income'
                : selectedFilter == 2
                ? 'Add your first expense'
                : 'Tap + to add your first transaction',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
