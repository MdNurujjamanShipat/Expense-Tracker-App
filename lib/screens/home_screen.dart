import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/transaction_list_header.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/filtered_transaction_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_floating_action_button.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const HomeAppBar(),
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          List<Transaction> filteredTransactions = viewModel.transactions;
          if (_selectedFilter == 1) {
            filteredTransactions = viewModel.transactions
                .where((t) => t.type == TransactionType.income)
                .toList();
          } else if (_selectedFilter == 2) {
            filteredTransactions = viewModel.transactions
                .where((t) => t.type == TransactionType.expense)
                .toList();
          }

          int allCount = viewModel.getTransactionCount();
          int incomeCount = viewModel.transactions
              .where((t) => t.type == TransactionType.income)
              .length;
          int expenseCount = viewModel.transactions
              .where((t) => t.type == TransactionType.expense)
              .length;

          return Column(
            children: [
              DashboardSection(
                totalBalance: viewModel.getTotalBalance(),
                totalIncome: viewModel.getTotalIncome(),
                totalExpense: viewModel.getTotalExpense(),
                greeting: _getGreeting(),
              ),
              const SizedBox(height: 24),
              TransactionListHeader(
                transactionCount: viewModel.getTransactionCount(),
              ),
              const SizedBox(height: 8),

              FilterButtons(
                selectedFilter: _selectedFilter,
                allCount: allCount,
                incomeCount: incomeCount,
                expenseCount: expenseCount,
                onFilterChanged: (index) {
                  setState(() {
                    _selectedFilter = index;
                  });
                },
              ),

              const SizedBox(height: 8),

              Expanded(
                child: FilteredTransactionList(
                  transactions: filteredTransactions,
                  selectedFilter: _selectedFilter,
                  onDelete: (transaction) {
                    viewModel.deleteTransaction(transaction.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text('Transaction deleted'),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: const HomeFloatingActionButton(),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().toLocal().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon';
    } else if (hour >= 16 && hour < 19) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
