import 'package:flutter/material.dart';
import '../../utils/datetime_helper.dart';
import '../models/datetime_slot.dart';

class DatetimeSlotListItem extends StatelessWidget {
  const DatetimeSlotListItem({
    super.key,
    required this.datetimeSlot,
  });

  final DatetimeSlot datetimeSlot;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 7.5,
        horizontal: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Slot #${datetimeSlot.id}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  DatetimeHelper.formatDatetimeString(datetimeSlot.slotDatetime),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: datetimeSlot.isFree
                  ? [
                      Icon(Icons.check),
                      Text('Free'),
                    ]
                  : [
                      Icon(Icons.close),
                      Text('Booked'),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
