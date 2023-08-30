import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/appointment.dart';
import '../../screens/patient/patient_appointment_form.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/appointment_list_item.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({
    super.key,
    required this.appointments,
  });

  final List<Appointment> appointments;

  void onSelectItem(BuildContext context, Appointment appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PatientAppointmentFormScreen(
          appointment: appointment,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'My Appointments',
        ),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        prototypeItem: AppointmentListItem(
          userRole: UserRole.patient,
          appointment: appointments.first,
          onSelectItem: () {},
        ),
        itemBuilder: (context, index) {
          return AppointmentListItem(
            userRole: UserRole.patient,
            appointment: appointments[index],
            onSelectItem: () {
              onSelectItem(context, appointments[index]);
            },
          );
        },
      ),
    );
  }
}
