import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_type_selector.dart';
import '../widgets/amount_input_field.dart';
import '../widgets/description_input_field.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/category_suggestions.dart';
import '../widgets/save_button.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TransactionType _selectedType = TransactionType.expense;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E3A8A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: double.parse(_amountController.text),
        title: _titleController.text.trim(),
        date: _selectedDate,
        type: _selectedType,
      );
      Navigator.pop(context, transaction);
    }
  }

  void _handleCategorySelected(String category) {
    setState(() {
      _titleController.text = category
          .replaceFirst(RegExp(r'[^\w\s]'), '')
          .trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = _selectedType == TransactionType.income;
    final accentColor = isIncome ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'New Transaction',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.grey.shade800,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TransactionTypeSelector(
                    selectedType: _selectedType,
                    onTypeChanged: (type) {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  AmountInputField(
                    controller: _amountController,
                    accentColor: accentColor,
                  ),
                  const SizedBox(height: 20),
                  DescriptionInputField(
                    controller: _titleController,
                    accentColor: accentColor,
                  ),
                  const SizedBox(height: 20),
                  DatePickerField(
                    selectedDate: _selectedDate,
                    accentColor: accentColor,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  CategorySuggestions(
                    selectedType: _selectedType,
                    accentColor: accentColor,
                    onCategorySelected: _handleCategorySelected,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            SaveButton(isIncome: isIncome, onPressed: _submitForm),
          ],
        ),
      ),
    );
  }
}
