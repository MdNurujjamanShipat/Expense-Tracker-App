import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/transaction_list_header.dart';
import '../widgets/transaction_list_item.dart';
import '../widgets/empty_transaction_state.dart';
import '../constants/app_constants.dart';
import 'add_transaction_screen.dart';
import '../models/transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppConstants.primaryGradient,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: () {
                  context.read<TransactionViewModel>().loadTransactions();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Refreshed successfully'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                tooltip: 'Refresh',
              ),
            ),
          ),
        ],
      ),
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
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
              Expanded(
                child: viewModel.hasTransactions
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: viewModel.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = viewModel.transactions[index];
                          return TransactionListItem(
                            transaction: transaction,
                            onDelete: () {
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
                          );
                        },
                      )
                    : const EmptyTransactionState(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: AppConstants.primaryGradient),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppConstants.deepBlue.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push<Transaction>(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTransactionScreen(),
              ),
            );

            if (result != null) {
              context.read<TransactionViewModel>().addTransaction(result);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Text('Transaction added successfully'),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'Add Transaction',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
