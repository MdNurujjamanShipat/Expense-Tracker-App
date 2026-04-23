import 'package:flutter/material.dart';

enum TransactionType { income, expense }

extension TransactionTypeExtension on TransactionType {
  String get string {
    switch (this) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
    }
  }

  Color get color {
    switch (this) {
      case TransactionType.income:
        return Colors.green;
      case TransactionType.expense:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.income:
        return Icons.arrow_downward;
      case TransactionType.expense:
        return Icons.arrow_upward;
    }
  }
}

class Transaction {
  final String id;
  final double amount;
  final String title;
  final DateTime date;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.amount,
    required this.title,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'title': title,
      'date': date.toIso8601String(),
      'type': type.index,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: json['amount'] as double,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values[json['type'] as int],
    );
  }

  Transaction copyWith({
    String? id,
    double? amount,
    String? title,
    DateTime? date,
    TransactionType? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      title: title ?? this.title,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, amount: $amount, title: $title, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Transaction &&
        other.id == id &&
        other.amount == amount &&
        other.title == title &&
        other.date == date &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        title.hashCode ^
        date.hashCode ^
        type.hashCode;
  }
}
