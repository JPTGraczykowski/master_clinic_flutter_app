import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/widgets/screen_title.dart';
import '../../widgets/forms/appointment_form.dart';

class PatientNewAppointmentScreen extends StatelessWidget {
  const PatientNewAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'New Appointment',
        ),
      ),
      body: AppointmentForm(),
    );
  }
}
