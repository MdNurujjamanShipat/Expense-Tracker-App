import 'package:flutter/material.dart';

class DescriptionInputField extends StatelessWidget {
  final TextEditingController controller;
  final Color accentColor;

  const DescriptionInputField({
    super.key,
    required this.controller,
    required this.accentColor,
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
            'Description',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'What was this for?',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(
                Icons.edit_note_rounded,
                color: accentColor.withOpacity(0.6),
                size: 22,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}
