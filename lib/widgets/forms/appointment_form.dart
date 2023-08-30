import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import '../../utils/input_decoration.dart';
import '../../widgets/primary_button.dart';
import '../../data/mock_data.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

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
                ),
                items: [
                  for (final specialty in mockSpecialties)
                    DropdownMenuItem(
                      value: specialty.id,
                      child: Text(specialty.name),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _specialtyId = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DateTimeField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Date and Time',
                ),
                selectedDate: _dateTime,
                dateFormat: DateFormat('MMMM dd HH:mm'),
                onDateSelected: (DateTime value) {
                  setState(() {
                    _dateTime = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Doctor',
                ),
                items: [
                  for (final doctor in mockDoctors)
                    DropdownMenuItem(
                      value: doctor.id,
                      child: Text(doctor.fullName),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _doctorId = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Patient',
                ),
                items: [
                  for (final patient in mockPatients)
                    DropdownMenuItem(
                      value: patient.id,
                      child: Text(patient.fullName),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _patientId = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Description',
                ),
                controller: _descriptionController,
                maxLines: 5,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: FormHelper.inputDecoration(
                  context: context,
                  labelText: 'Cabinet',
                ),
                items: [
                  for (final cabinet in mockCabinets)
                    DropdownMenuItem(
                      value: cabinet.id,
                      child: Text(cabinet.name),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    _cabinetId = value!;
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
