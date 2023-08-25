import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/utils/datetime_helper.dart';

import '../models/appointment.dart';

class AppointmentListItem extends StatelessWidget {
  const AppointmentListItem({
    super.key,
    required this.appointment,
    required this.onSelectItem,
  });

  final Appointment appointment;
  final void Function() onSelectItem;

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
              'ID: #${appointment.id}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              DatetimeHelper.formatDatetime(appointment.dateTime),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              appointment.specialty.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              'Patient: ${appointment.patient.fullName}',
            ),
            Text(
              'Cabinet: ${appointment.cabinet.name}',
            )
          ],
        ),
      ),
    );
  }
}
