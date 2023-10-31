import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../utils/api_helper.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/appointment_list_item.dart';
import '../../models/appointment.dart';
import 'appointment_form.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({
    super.key,
    required this.userRole,
  });

  final UserRole userRole;

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late Future<List<Appointment>> _fetchedAppointments;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchedAppointments = fetchAppointments();
  }

  Future<List<Appointment>> fetchAppointments() async {
    final url = ApiHelper.appointmentsIndex();
    final response = await ApiHelper.sendGetRequest(url);
    List<Appointment> loadedAppointments = [];

    if (response == null || response.statusCode! >= 400) {
      onFailureFetchingData();
      return [];
    }

    Map<String, dynamic> responseData = response.data;

    for (Map<String, dynamic> jsonObject in responseData['data']) {
      Appointment appointment = Appointment.fromJson(jsonObject['attributes']);
      loadedAppointments.add(appointment);
    }

    return loadedAppointments;
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
    });
  }

  void onSelectItem(BuildContext context, Appointment appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AppointmentFormScreen(
          appointmentId: appointment.id,
          userRole: widget.userRole,
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
      body: FutureBuilder(
        future: _fetchedAppointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(_error));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no appointments'));
          }

          final appointments = snapshot.data!;

          return ListView.builder(
            itemCount: appointments.length,
            prototypeItem: AppointmentListItem(
              userRole: widget.userRole,
              appointment: appointments.first,
              onSelectItem: () {},
            ),
            itemBuilder: (context, index) {
              return AppointmentListItem(
                userRole: widget.userRole,
                appointment: appointments[index],
                onSelectItem: () {
                  onSelectItem(context, appointments[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
