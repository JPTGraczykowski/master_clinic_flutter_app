import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/screen_title.dart';
import '../../models/appointment.dart';
import '../../widgets/appointment_list_item.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({
    super.key,
    required this.appointments,
  });

  final List<Appointment> appointments;

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
            onSelectItem: () {},
          );
        },
      ),
    );
  }
}
