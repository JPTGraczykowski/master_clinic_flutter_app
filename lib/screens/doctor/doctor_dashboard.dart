import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../screens/doctor/doctor_appointments.dart';
import '../../screens/doctor/doctor_datetime_slots.dart';
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
        break;
      case 'datetimeSlots':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorDatetimeSlotsScreen(
              datetimeSlots: mockDatetimeSlots,
            ),
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
          padding: const EdgeInsets.all(16),
          children: [
            DashboardListItem(
              title: 'My Appointments',
              onSelectItem: () {
                onSelectItem(context, 'appointments');
              },
            ),
            DashboardListItem(
              title: 'My Slots',
              onSelectItem: () {
                onSelectItem(context, 'datetimeSlots');
              },
            ),
            DashboardListItem(title: 'My Cabinets', onSelectItem: () {}),
          ],
        ));
  }
}
