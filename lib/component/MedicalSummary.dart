import 'package:flutter/material.dart';

class MedicalSummary extends StatelessWidget {
  const MedicalSummary({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        textAlign: TextAlign.justify, // Justifies the text
        description,
        softWrap: true,
      ),
    );
  }
}