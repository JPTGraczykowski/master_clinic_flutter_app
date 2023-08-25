import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/widgets/dashboard_list_item.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DashboardListItem(title: 'My Appointments', onSelectItem: () {}),
            DashboardListItem(title: 'My Slots', onSelectItem: () {}),
            DashboardListItem(title: 'My Cabinets', onSelectItem: () {}),
          ],
        ));
  }
}
