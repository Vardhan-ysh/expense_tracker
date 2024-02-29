import 'package:expense_tracker/models/expence.dart';
import 'package:expense_tracker/widgets/expences_list/expence_item.dart';
import 'package:flutter/material.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList(
      {super.key, required this.expences, required this.onDismissed});

  final List<Expence> expences;
  final void Function(Expence, int) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expences.length,
      itemBuilder: ((context, index) {
        return Dismissible(
          background: Container(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(expences[index]),
          onDismissed: (direction) {
            onDismissed(expences[index], index);
          },
          child: ExpenceItem(expence: expences[index]),
        );
      }),
    );
  }
}
