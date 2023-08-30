import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/screens/patient/patient_appointment_form.dart';
import '../../data/mock_data.dart';
import '../../screens/patient/patient_appointments.dart';
import '../../widgets/dashboard_list_item.dart';
import '../../widgets/screen_title.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  void onSelectItem(BuildContext context, String item) {
    switch (item) {
      case 'appointments':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PatientAppointmentsScreen(
              appointments: mockAppointments,
            ),
          ),
        );
        break;
      case 'new_appointment':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PatientAppointmentFormScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'Dashboard',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 7.5,
          horizontal: 5,
        ),
        children: [
          DashboardListItem(
            title: 'My Appointments',
            onSelectItem: () {
              onSelectItem(context, 'appointments');
            },
          ),
          DashboardListItem(
            title: 'Add New Appointment',
            onSelectItem: () {
              onSelectItem(context, 'new_appointment');
            },
          ),
        ],
      ),
    );
  }
}
