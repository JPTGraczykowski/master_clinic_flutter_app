import 'package:flutter/material.dart';
import '../../screens/doctor/datetime_slot_form.dart';
import '../../utils/api_helper.dart';
import '../../widgets/add_date_time_slot_button.dart';
import '../../widgets/datetime_slot_list_item.dart';
import '../../widgets/screen_title.dart';
import '../../models/datetime_slot.dart';

class DoctorDatetimeSlotsScreen extends StatefulWidget {
  const DoctorDatetimeSlotsScreen({
    super.key,
  });

  @override
  State<DoctorDatetimeSlotsScreen> createState() => _DoctorDatetimeSlotsScreenState();
}

class _DoctorDatetimeSlotsScreenState extends State<DoctorDatetimeSlotsScreen> {
  late Future<List<DatetimeSlot>> _fetchedDatetimeSlots;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchedDatetimeSlots = fetchDatetimeSlots();
  }

  Future<List<DatetimeSlot>> fetchDatetimeSlots() async {
    final url = ApiHelper.datetimeSlotIndex();
    final response = await ApiHelper.sendGetRequest(url);
    List<DatetimeSlot> loadedDatetimeSlots = [];

    if (response == null || response.statusCode! >= 400) {
      onFailureFetchingData();
      return [];
    }

    Map<String, dynamic> responseData = response.data;

    for (Map<String, dynamic> jsonObject in responseData['data']) {
      DatetimeSlot datetimeSlot = DatetimeSlot.fromJson(jsonObject['attributes']);
      loadedDatetimeSlots.add(datetimeSlot);
    }

    return loadedDatetimeSlots;
  }

  void onFailureFetchingData() {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
    });
  }

  void onSelectItem(BuildContext context, DatetimeSlot datetimeSlot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => DatetimeSlotFormScreen(
          slotId: datetimeSlot.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenTitle(
            title: 'My Slots',
          ),
          actions: [
            AddDatetimeSlotButton(),
          ],
        ),
        body: FutureBuilder(
          future: _fetchedDatetimeSlots,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(_error));
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('You have no Datetime Slots'));
            }

            final datetimeSlots = snapshot.data!;

            return ListView.builder(
              itemCount: datetimeSlots.length,
              prototypeItem: DatetimeSlotListItem(
                datetimeSlot: datetimeSlots.first,
                onSelectItem: () {
                  onSelectItem(context, datetimeSlots.first);
                },
              ),
              itemBuilder: (context, index) {
                return DatetimeSlotListItem(
                  datetimeSlot: datetimeSlots[index],
                  onSelectItem: () {
                    onSelectItem(context, datetimeSlots[index]);
                  },
                );
              },
            );
          },
        ));
  }
}
