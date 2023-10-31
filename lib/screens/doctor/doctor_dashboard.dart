import 'package:flutter/material.dart';
import '../../widgets/sign_out_button.dart';
import '../../screens/doctor/doctor_cabinets.dart';
import '../../screens/doctor/doctor_appointments.dart';
import '../../screens/doctor/doctor_datetime_slots.dart';
import '../../widgets/dashboard_list_item.dart';
import '../../widgets/screen_title.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({
    super.key,
  });

  void onSelectItem(BuildContext context, String item) {
    switch (item) {
      case 'appointments':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorAppointmentsScreen(
              appointments: [],
            ),
          ),
        );
        break;
      case 'datetimeSlots':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorDatetimeSlotsScreen(
              datetimeSlots: [],
            ),
          ),
        );
        break;
      case 'cabinets':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DoctorCabinetsScreen(
              cabinets: [],
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 7.5,
                horizontal: 5,
              ),
              shrinkWrap: true,
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
                DashboardListItem(
                  title: 'My Cabinets',
                  onSelectItem: () {
                    onSelectItem(context, 'cabinets');
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: SignOutButton(),
            ),
          ],
        ));
  }
}
