import 'package:expense_tracker/models/expence.dart';
import 'package:flutter/material.dart';

class ExpenceItem extends StatelessWidget {
  const ExpenceItem({super.key, required this.expence});

  final Expence expence;

  @override
  Widget build(BuildContext context) {
    String expenceAmount = expence.amount.toStringAsFixed(2);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expence.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "₹$expenceAmount",
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expence.category]),
                    const SizedBox(width: 8),
                    Text(expence.getFormattedDate()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
