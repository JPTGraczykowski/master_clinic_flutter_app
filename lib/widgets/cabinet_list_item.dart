import 'package:flutter/material.dart';
import '../../models/cabinet.dart';

class CabinetListItem extends StatelessWidget {
  const CabinetListItem({
    super.key,
    required this.cabinet,
  });

  final Cabinet cabinet;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 7.5,
        horizontal: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cabinet: ${cabinet.name}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              'Floor: ${cabinet.floor}',
            ),
          ],
        ),
      ),
    );
  }
}
