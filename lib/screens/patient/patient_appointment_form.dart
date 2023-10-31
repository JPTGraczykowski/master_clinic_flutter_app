import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../models/user.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/forms/appointment_form.dart';

class PatientAppointmentFormScreen extends StatelessWidget {
  const PatientAppointmentFormScreen({
    super.key,
    this.appointmentId,
  });

  final int? appointmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: appointmentId == null ? 'New Appointment' : 'Appointment #$appointmentId',
        ),
      ),
      body: AppointmentForm(
        userRole: UserRole.patient,
        appointmentId: appointmentId,
      ),
    );
  }
}
