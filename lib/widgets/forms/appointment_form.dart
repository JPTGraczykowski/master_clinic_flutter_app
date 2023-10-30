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
    });
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
      _isLoading = false;
    });
  }

  String _specialtyId = '';
  DateTime _dateTime = DateTime.now();
  String _doctorId = '';
  String _patientId = '';
  final _descriptionController = TextEditingController();
  String _cabinetId = '';
  final _beforeVisitController = TextEditingController();

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
                value: _appointment?.specialty['text'],
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
                          _specialtyId = (value!).toString();
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
                value: _appointment?.doctor['text'],
                items: [
                  for (final doctor in [])
                    DropdownMenuItem(
                      value: doctor.id,
                      child: Text(doctor.fullName),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _doctorId = value! as String;
                  });
                },
              ),
              SizedBox(height: 16),
              DateTimeField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Date and Time',
                ),
                selectedDate: _appointment != null ? DateTime.parse(_appointment!.appointmentDatetime) : DateTime.now(),
                dateFormat: DateFormat('MMMM dd HH:mm'),
                onDateSelected: (DateTime value) {
                  setState(() {
                    _dateTime = value;
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
                  value: _appointment?.patient['text'],
                  items: [
                    for (final patient in [])
                      DropdownMenuItem(
                        value: patient.id,
                        child: Text(patient.fullName),
                      )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _patientId = value! as String;
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
                  value: _appointment?.cabinet['text'],
                  items: [
                    for (final cabinet in [])
                      DropdownMenuItem(
                        value: cabinet.id,
                        child: Text(cabinet.name),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _cabinetId = value! as String;
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
