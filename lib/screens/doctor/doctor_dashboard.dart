import 'package:flutter/material.dart';
import '../../widgets/dashboard_list_item.dart';
import '../../widgets/shared/screen_title.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

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
            DashboardListItem(title: 'My Appointments', onSelectItem: () {}),
            DashboardListItem(title: 'My Slots', onSelectItem: () {}),
            DashboardListItem(title: 'My Cabinets', onSelectItem: () {}),
          ],
        ));
  }
}
