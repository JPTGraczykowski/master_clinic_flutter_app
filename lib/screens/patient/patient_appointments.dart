import 'package:flutter/material.dart';
import '../../utils/api_helper.dart';
import '../../models/user.dart';
import '../../models/appointment.dart';
import '../../screens/patient/patient_appointment_form.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/appointment_list_item.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  State<PatientAppointmentsScreen> createState() => _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
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
        builder: (ctx) => PatientAppointmentFormScreen(
          appointment: appointment,
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
                userRole: UserRole.patient,
                appointment: appointments.first,
                onSelectItem: () {},
              ),
              itemBuilder: (context, index) {
                return AppointmentListItem(
                  userRole: UserRole.patient,
                  appointment: appointments[index],
                  onSelectItem: () {
                    onSelectItem(context, appointments[index]);
                  },
                );
              },
            );
          },
        ));
  }
}
