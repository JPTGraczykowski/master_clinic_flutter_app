import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:master_clinic_flutter_app/models/appointment.dart';
import 'package:master_clinic_flutter_app/models/user.dart';
import 'package:master_clinic_flutter_app/utils/api_helper.dart';
import '../../utils/datetime_helper.dart';
import '../../utils/input_decoration.dart';
import '../../widgets/primary_button.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({
    super.key,
    required this.userRole,
    this.appointmentId,
  });

  final UserRole userRole;
  final int? appointmentId;

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoading = false;
  String _error = '';
  Appointment? _appointment;
  int? _specialtyId;
  String _specialtyText = '';
  DateTime _appointmentDateTime = DateTime.now();
  int? _doctorId;
  String _doctorText = '';
  int? _patientId;
  String _patientText = '';
  int? _cabinetId;
  String _cabinetText = '';
  final _descriptionController = TextEditingController();
  final _beforeVisitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.appointmentId != null) {
      fetchAppointment(widget.appointmentId!);
    }
  }

  void fetchAppointment(int appointmentId) async {
    setState(() {
      _isLoading = true;
    });
    final url = ApiHelper.appointmentShow(appointmentId);
    final response = await ApiHelper.sendGetRequest(url);

    if (response == null || response.statusCode! >= 400) {
      onFailureFetchingData();
    }
    Map<String, dynamic> responseData = response!.data;

    Appointment appointment = Appointment.fromJson(responseData['data']['attributes']);

    setState(() {
      _appointment = appointment;
      _isLoading = false;
      _specialtyId = appointment.specialty['id'];
      _specialtyText = appointment.specialty['text'];
      _appointmentDateTime = DateTime.parse(appointment.appointmentDatetime);
      _doctorId = appointment.doctor['id'];
      _doctorText = appointment.doctor['text'];
      _patientId = appointment.patient['id'];
      _patientText = appointment.patient['text'];
      _cabinetId = appointment.cabinet['id'];
      _cabinetText = appointment.cabinet['text'];
      _descriptionController.text = appointment.description;
      _beforeVisitController.text = appointment.beforeVisit ?? '';
    });
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
      _isLoading = false;
    });
  }

  void _saveAppointment() {}

  @override
  Widget build(BuildContext context) {
    if (_error != '') {
      return Center(child: Text(_error));
    }
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Specialty',
                  fillColor: widget.userRole == UserRole.patient ? null : Colors.black12,
                ),
                value: _specialtyText,
                items: [
                  for (final specialty in [])
                    DropdownMenuItem(
                      value: specialty.id,
                      child: Text(specialty.name),
                    )
                ],
                onChanged: widget.userRole == UserRole.patient
                    ? (value) {
                        setState(() {
                          _specialtyId = value as int;
                        });
                      }
                    : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Doctor',
                ),
                value: _doctorText,
                items: [
                  for (final doctor in [])
                    DropdownMenuItem(
                      value: doctor.id,
                      child: Text(doctor.fullName),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _doctorId = value as int;
                  });
                },
              ),
              SizedBox(height: 16),
              DateTimeField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Date and Time',
                ),
                selectedDate: _appointmentDateTime,
                dateFormat: DateFormat('MMMM dd HH:mm'),
                onDateSelected: (DateTime value) {
                  setState(() {
                    _appointmentDateTime = value;
                  });
                },
              ),
              SizedBox(height: 16),
              if (widget.userRole == UserRole.doctor) ...[
                DropdownButtonFormField(
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Patient',
                  ),
                  value: _patientText,
                  items: [
                    for (final patient in [])
                      DropdownMenuItem(
                        value: patient.id,
                        child: Text(patient.fullName),
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _patientId = value as int;
                    });
                  },
                ),
                SizedBox(height: 16),
              ],
              TextFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Description',
                  fillColor: widget.userRole == UserRole.patient ? null : Colors.black12,
                ),
                controller: _descriptionController,
                maxLines: 5,
                readOnly: widget.userRole == UserRole.doctor,
              ),
              SizedBox(height: 16),
              if (widget.userRole == UserRole.doctor) ...[
                DropdownButtonFormField(
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Cabinet',
                  ),
                  value: _cabinetText,
                  items: [
                    for (final cabinet in [])
                      DropdownMenuItem(
                        value: cabinet.id,
                        child: Text(cabinet.name),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _cabinetId = value as int;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Before Visit',
                  ),
                  controller: _beforeVisitController,
                  maxLines: 5,
                ),
              ],
              SizedBox(height: 32),
              PrimaryButton(
                onPressed: _isSending ? null : _saveAppointment,
                content: _isSending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Save',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
