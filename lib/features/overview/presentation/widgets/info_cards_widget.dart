import 'package:flutter/material.dart';

import '../../../../core/utils/status_summary_converter.dart';
import '../../domain/models/status_summary_model.dart';

class InfoCardsWidget extends StatelessWidget {
  final StatusSummaryModel summary;
  const InfoCardsWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...StatusSummaryConverter.convertToInfoCards(summary),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}