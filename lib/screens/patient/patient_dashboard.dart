import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/widgets/dashboard_list_item.dart';
import 'package:master_clinic_flutter_app/widgets/shared/screen_title.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({
    super.key,
  });

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
            onSelectItem: () {},
          ),
          DashboardListItem(
            title: 'Add New Appointment',
            onSelectItem: () {},
          )
        ],
      ),
    );
  }
}
