import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/data/mock_data.dart';
import 'package:master_clinic_flutter_app/screens/doctor/doctor_appointments.dart';
import '../../widgets/dashboard_list_item.dart';
import '../../widgets/shared/screen_title.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  void onSelectItem(BuildContext context, String item) {
    switch (item) {
      case 'appointments':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorAppointmentsScreen(
              appointments: mockAppointments,
            ),
          ),
        );
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
          padding: const EdgeInsets.all(16),
          children: [
            DashboardListItem(
              title: 'My Appointments',
              onSelectItem: () {
                onSelectItem(context, 'appointments');
              },
            ),
            DashboardListItem(title: 'My Slots', onSelectItem: () {}),
            DashboardListItem(title: 'My Cabinets', onSelectItem: () {}),
          ],
        ));
  }
}
