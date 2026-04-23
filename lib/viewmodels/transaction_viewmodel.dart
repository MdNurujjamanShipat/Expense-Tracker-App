import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';

class TransactionViewModel extends ChangeNotifier {
  List<Transaction> _transactions = [];
  static const String _transactionsKey = 'transactions';
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  TransactionViewModel() {
    loadTransactions();
  }
  Future<void> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? transactionsJson = prefs.getString(_transactionsKey);

      if (transactionsJson != null) {
        final List<dynamic> decodedList = json.decode(transactionsJson);
        _transactions = decodedList
            .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
            .toList();
        _transactions.sort((a, b) => b.date.compareTo(a.date));

        notifyListeners();
      } else {
        _transactions = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading transactions: $e');
      _transactions = [];
      notifyListeners();
    }
  }

  Future<void> _saveTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> transactionsMap = _transactions
          .map((transaction) => transaction.toJson())
          .toList();
      final String transactionsJson = json.encode(transactionsMap);
      await prefs.setString(_transactionsKey, transactionsJson);
    } catch (e) {
      debugPrint('Error saving transactions: $e');
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    await _saveTransactions();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await _saveTransactions();
    notifyListeners();
  }

  double getTotalIncome() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double getTotalExpense() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double getTotalBalance() {
    return getTotalIncome() - getTotalExpense();
  }

  int getTransactionCount() {
    return _transactions.length;
  }

  bool get hasTransactions => _transactions.isNotEmpty;

  List<Transaction> getRecentTransactions({int limit = 10}) {
    if (_transactions.length <= limit) {
      return List.unmodifiable(_transactions);
    }
    return List.unmodifiable(_transactions.sublist(0, limit));
  }

  Future<void> clearAllTransactions() async {
    _transactions.clear();
    await _saveTransactions();
    notifyListeners();
  }
}
