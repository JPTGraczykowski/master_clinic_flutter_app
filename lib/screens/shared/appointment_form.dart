import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:master_clinic_flutter_app/main.dart';
import 'package:master_clinic_flutter_app/utils/datetime_helper.dart';
import '../../models/appointment.dart';
import '../../models/user.dart';
import '../../utils/api_helper.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/forms/fields/api_dropdown_form_field.dart';
import '../../utils/input_decoration.dart';
import '../../widgets/primary_button.dart';

class AppointmentFormScreen extends StatefulWidget {
  const AppointmentFormScreen({
    super.key,
    this.appointmentId,
    required this.userRole,
  });

  final int? appointmentId;
  final UserRole userRole;

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoading = false;
  String _error = '';
  int? _specialtyId;
  DateTime _appointmentDateTime = DateTime.now();
  int? _doctorId;
  int? _patientId;
  int? _cabinetId;
  int? _datetimeSlotId;
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
      _isLoading = false;
      _specialtyId = appointment.specialty['id'];
      _appointmentDateTime = DateTime.parse(appointment.appointmentDatetime);
      _doctorId = appointment.doctor['id'];
      _patientId = appointment.patient['id'];
      _cabinetId = appointment.cabinet['id'];
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

  Map<String, dynamic> newAppointmentParams() {
    return {
      'specialty_id': _specialtyId,
      'doctor_id': _doctorId,
      'datetime_slot_id': _datetimeSlotId,
      'description': _descriptionController.text,
    };
  }

  Map<String, dynamic> updateAppointmentParams() {
    return {
      'before_visit': _beforeVisitController.text,
      'description': _descriptionController.text,
      'cabinet_it': _cabinetId,
    };
  }

  void saveNewAppointment() async {
    setState(() {
      _isSending = true;
    });
    final url = ApiHelper.appointmentCreate();
    Map<String, Map<String, dynamic>> appointmentBody = {
      'appointment': newAppointmentParams(),
    };
    final response = await ApiHelper.sendPostRequest(url, appointmentBody);

    if (response != null && response.statusCode == 201) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Appointment was saved successfully'),
        ),
      );
      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => AppointmentFormScreen(
            userRole: widget.userRole,
            appointmentId: int.parse(response.data['data']['id']),
          ),
        ),
      );
    } else {
      setState(() {
        _isSending = false;
        _error = 'Appointment was NOT saved';
      });
    }
  }

  void updateAppointment() async {
    setState(() {
      _isSending = true;
    });
    final url = ApiHelper.appointmentUpdate(widget.appointmentId!);
    Map<String, Map<String, dynamic>> appointmentBody = {
      'appointment': updateAppointmentParams(),
    };
    final response = await ApiHelper.sendPatchRequest(url, appointmentBody);

    if (response != null && response.statusCode == 200) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Appointment was updated successfully'),
        ),
      );
      setState(() {
        _isSending = false;
      });
    } else {
      setState(() {
        _isSending = false;
        _error = 'Appointment was NOT saved';
      });
    }
  }

  void onSubmitForm() {
    if (widget.appointmentId != null) {
      updateAppointment();
    } else {
      saveNewAppointment();
    }
  }

  Widget renderForm() {
    if (_error != '') {
      return Center(child: Text(_error));
    }
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    bool appointmentExists = widget.appointmentId != null;

    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ApiDropdownFormField(
                url: ApiHelper.specialties(),
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Specialty',
                  fillColor: appointmentExists ? Colors.black12 : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _specialtyId = value as int;
                  });
                },
                initialId: _specialtyId,
                disabled: appointmentExists,
              ),
              SizedBox(height: 16),
              if (widget.userRole == UserRole.patient) ...[
                ApiDropdownFormField(
                  url: ApiHelper.doctors(specialtyId: _specialtyId),
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Doctor',
                    fillColor: (appointmentExists && widget.userRole == UserRole.patient) || _specialtyId == null
                        ? Colors.black12
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _doctorId = value as int;
                    });
                  },
                  initialId: _doctorId,
                  disabled: (appointmentExists && widget.userRole == UserRole.patient) || _specialtyId == null,
                ),
              ],
              SizedBox(height: 16),
              if (appointmentExists)
                DateTimeField(
                  dateTextStyle: textStyle,
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Date and Time',
                    fillColor: widget.userRole == UserRole.doctor ? null : Colors.black12,
                  ),
                  selectedDate: _appointmentDateTime,
                  dateFormat: DateFormat('MMMM dd HH:mm'),
                  onDateSelected: (DateTime value) {
                    setState(() {
                      _appointmentDateTime = value;
                    });
                  },
                  enabled: widget.userRole == UserRole.doctor,
                )
              else
                ApiDropdownFormField(
                  url: ApiHelper.datetimeSlots(doctorId: _doctorId),
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Date and Time',
                    fillColor: _doctorId == null ? Colors.black12 : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _datetimeSlotId = value as int;
                    });
                  },
                  renderMenuItemWidget: (String dateTime) {
                    return Text(
                      DatetimeHelper.formatDatetimeString(dateTime),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).colorScheme.primary),
                    );
                  },
                  disabled: _doctorId == null,
                ),
              SizedBox(height: 16),
              if (widget.userRole == UserRole.doctor) ...[
                ApiDropdownFormField(
                  url: ApiHelper.patients(),
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Patient',
                    fillColor: Colors.black12,
                  ),
                  onChanged: null,
                  initialId: _patientId,
                  disabled: true,
                ),
                SizedBox(height: 16),
              ],
              TextFormField(
                style: textStyle,
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Description',
                  fillColor: widget.userRole == UserRole.doctor ? Colors.black12 : null,
                ),
                controller: _descriptionController,
                maxLines: 5,
                readOnly: widget.userRole == UserRole.doctor,
              ),
              SizedBox(height: 16),
              if (appointmentExists) ...[
                ApiDropdownFormField(
                  url: ApiHelper.cabinets(doctorId: _doctorId),
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Cabinet',
                    fillColor: widget.userRole == UserRole.patient ? Colors.black12 : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _cabinetId = value as int;
                    });
                  },
                  initialId: _cabinetId,
                  disabled: widget.userRole == UserRole.patient,
                ),
                SizedBox(height: 16),
                TextFormField(
                  style: textStyle,
                  decoration: FormHelper.inputDecoration(
                    context: context,
                    labelText: 'Before Visit',
                    fillColor: widget.userRole == UserRole.patient ? Colors.black12 : null,
                  ),
                  controller: _beforeVisitController,
                  maxLines: 5,
                  readOnly: widget.userRole == UserRole.patient,
                ),
              ],
              SizedBox(height: 32),
              PrimaryButton(
                onPressed: _isSending ? null : onSubmitForm,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: widget.appointmentId != null ? 'Appointment #${widget.appointmentId}' : 'New Appointment',
        ),
      ),
      body: renderForm(),
    );
  }
}
