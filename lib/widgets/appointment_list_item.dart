import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../utils/datetime_helper.dart';

import '../models/appointment.dart';

class AppointmentListItem extends StatelessWidget {
  const AppointmentListItem({
    super.key,
    required this.userRole,
    required this.appointment,
    required this.onSelectItem,
  });

  final UserRole userRole;
  final Appointment appointment;
  final void Function() onSelectItem;

  String appointmentTargetPersonDetails(UserRole role, Appointment appointment) {
    if (role == UserRole.doctor) {
      return 'Patient: ${appointment.patient['text']}';
    }
    return 'Doctor: ${appointment.doctor['text']}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectItem,
      child: Card(
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
                DatetimeHelper.formatDatetimeString(appointment.appointmentDatetime),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                appointment.specialty['text'],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                appointmentTargetPersonDetails(userRole, appointment),
              ),
              Text(
                'Cabinet: ${appointment.cabinet['text']}',
              )
            ],
          ),
        ),
      ),
    );
  }
}
