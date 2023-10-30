import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../models/user.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/forms/appointment_form.dart';

class DoctorAppointmentFormScreen extends StatelessWidget {
  const DoctorAppointmentFormScreen({
    super.key,
    required this.appointmentId,
  });

  final int appointmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'Appointment #$appointmentId',
        ),
      ),
      body: AppointmentForm(
        userRole: UserRole.doctor,
        appointmentId: appointmentId,
      ),
    );
  }
}
