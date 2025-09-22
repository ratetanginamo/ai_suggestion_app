import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final String text;
  const SuggestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
