import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:master_clinic_flutter_app/models/datetime_slot.dart';
import 'package:master_clinic_flutter_app/screens/doctor/doctor_datetime_slots.dart';
import 'package:master_clinic_flutter_app/utils/datetime_helper.dart';

import '../../main.dart';
import '../../utils/api_helper.dart';
import '../../utils/input_decoration.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/screen_title.dart';

class DatetimeSlotFormScreen extends StatefulWidget {
  const DatetimeSlotFormScreen({
    super.key,
    this.slotId,
  });

  final int? slotId;

  @override
  State<DatetimeSlotFormScreen> createState() => _DatetimeSlotFormScreenState();
}

class _DatetimeSlotFormScreenState extends State<DatetimeSlotFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isLoading = false;
  String _error = '';
  DateTime _dateTime = DateTime.now();
  bool _isFree = true;

  @override
  void initState() {
    super.initState();
    if (widget.slotId != null) {
      fetchSlot(widget.slotId!);
    }
  }

  void fetchSlot(int slotId) async {
    setState(() {
      _isLoading = true;
    });
    final url = ApiHelper.datetimeSlotShow(slotId);
    final response = await ApiHelper.sendGetRequest(url);

    if (response == null || response.statusCode! >= 400) {
      onFailureFetchingData();
    }
    Map<String, dynamic> responseData = response!.data;

    DatetimeSlot datetimeSlot = DatetimeSlot.fromJson(responseData['data']['attributes']);

    setState(() {
      _isLoading = false;
      _dateTime = DateTime.parse(datetimeSlot.slotDatetime);
      _isFree = datetimeSlot.isFree;
    });
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
      _isLoading = false;
    });
  }

  Map<String, dynamic> slotParams() {
    return {
      'slot_datetime': DatetimeHelper.prepareDatetimeToSend(_dateTime),
      'is_free': _isFree,
    };
  }

  void saveNewSlot() async {
    setState(() {
      _isSending = true;
    });
    final url = ApiHelper.datetimeSlotCreate();
    Map<String, Map<String, dynamic>> slotBody = {
      'datetime_slot': slotParams(),
    };
    final response = await ApiHelper.sendPostRequest(url, slotBody);

    if (response != null && response.statusCode == 201) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Datetime Slot was saved successfully'),
        ),
      );
      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => DoctorDatetimeSlotsScreen(),
        ),
      );
    } else {
      setState(() {
        _isSending = false;
        _error = 'Datetime Slot was NOT saved';
      });
    }
  }

  void updateSlot() async {
    setState(() {
      _isSending = true;
    });
    final url = ApiHelper.datetimeSlotUpdate(widget.slotId!);
    Map<String, Map<String, dynamic>> slotBody = {
      'datetime_slot': slotParams(),
    };
    final response = await ApiHelper.sendPatchRequest(url, slotBody);

    if (response != null && response.statusCode == 200) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Datetime Slot was updated successfully'),
        ),
      );
      setState(() {
        _isSending = false;
      });
    } else {
      setState(() {
        _isSending = false;
        _error = 'Datetime Slot was NOT saved';
      });
    }
  }

  void deleteSlot() async {
    setState(() {
      _isSending = true;
    });
    final url = ApiHelper.datetimeSlotDelete(widget.slotId!);
    final response = await ApiHelper.sendDeleteRequest(url);

    if (response != null && response.statusCode == 200) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Datetime Slot was deleted successfully'),
        ),
      );
      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => DoctorDatetimeSlotsScreen(),
        ),
      );
    } else {
      setState(() {
        _isSending = false;
        _error = 'Datetime Slot was NOT deleted';
      });
    }
  }

  void onSubmitForm() {
    if (widget.slotId != null) {
      updateSlot();
    } else {
      saveNewSlot();
    }
  }

  Widget renderForm() {
    if (_error != '') {
      return Center(child: Text(_error));
    }
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    bool slotExists = widget.slotId != null;

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
              DateTimeField(
                dateTextStyle: textStyle,
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
                  labelText: 'Is Free?',
                ),
                items: [
                  for (final value in [true, false])
                    DropdownMenuItem(
                      value: value,
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        value ? 'Yes' : 'No',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                ],
                value: _isFree,
                onChanged: (value) {
                  setState(() {
                    _isFree = value as bool;
                  });
                },
                elevation: 16,
                menuMaxHeight: 400,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                    size: Size(150, 50),
                  ),
                  if (slotExists) ...[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: _isSending ? null : deleteSlot,
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Delete',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                      ),
                    ),
                  ],
                ],
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
          title: widget.slotId != null ? 'Edit Slot' : 'New Slot',
        ),
      ),
      body: renderForm(),
    );
  }
}
