import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../models/user.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/forms/appointment_form.dart';

class PatientAppointmentFormScreen extends StatelessWidget {
  const PatientAppointmentFormScreen({
    super.key,
    this.appointment,
  });

  final Appointment? appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: appointment == null ? 'New Appointment' : 'Appointment #${appointment!.id}',
        ),
      ),
      body: AppointmentForm(
        userRole: UserRole.patient,
        appointment: appointment,
      ),
    );
  }
}
