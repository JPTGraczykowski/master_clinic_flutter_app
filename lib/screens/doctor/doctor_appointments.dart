import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/appointment_list_item.dart';
import '../../models/appointment.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  const DoctorAppointmentsScreen({
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
          userRole: UserRole.doctor,
          appointment: appointments.first,
          onSelectItem: () {},
        ),
        itemBuilder: (context, index) {
          return AppointmentListItem(
            userRole: UserRole.doctor,
            appointment: appointments[index],
            onSelectItem: () {},
          );
        },
      ),
    );
  }
}
