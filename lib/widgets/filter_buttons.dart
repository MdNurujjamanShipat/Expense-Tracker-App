import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final int selectedFilter;
  final int allCount;
  final int incomeCount;
  final int expenseCount;
  final ValueChanged<int> onFilterChanged;

  const FilterButtons({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.incomeCount,
    required this.expenseCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _buildFilterButton(index: 0, title: 'All', count: allCount),
          const SizedBox(width: 12),
          _buildFilterButton(
            index: 1,
            title: 'Income',
            count: incomeCount,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          _buildFilterButton(
            index: 2,
            title: 'Expense',
            count: expenseCount,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required int index,
    required String title,
    required int count,
    Color? color,
  }) {
    final isSelected = selectedFilter == index;
    final buttonColor = color ?? (index == 0 ? Colors.blue : Colors.grey);

    return GestureDetector(
      onTap: () => onFilterChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? buttonColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? buttonColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? buttonColor : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? buttonColor.withOpacity(0.2)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? buttonColor : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
