import 'package:flutter/material.dart';
import '../models/transaction.dart';

class CategorySuggestions extends StatelessWidget {
  final TransactionType selectedType;
  final Color accentColor;
  final ValueChanged<String> onCategorySelected;

  const CategorySuggestions({
    super.key,
    required this.selectedType,
    required this.accentColor,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Suggestions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _getCategorySuggestions().map((category) {
              return _buildSuggestionChip(category);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String category) {
    return ActionChip(
      label: Text(
        category,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: accentColor,
        ),
      ),
      onPressed: () {
        onCategorySelected(category);
      },
      backgroundColor: accentColor.withOpacity(0.1),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    );
  }

  List<String> _getCategorySuggestions() {
    if (selectedType == TransactionType.expense) {
      return [
        'Food',
        'Transport',
        'Shopping',
        'Bills',
        'Entertainment',
        'Education',
      ];
    } else {
      return ['Salary', 'Freelance', 'Investment', 'Gift', 'Bonus', 'Interest'];
    }
  }
}
