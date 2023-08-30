import 'package:flutter/material.dart';
import '../../widgets/datetime_slot_list_item.dart';
import '../../widgets/screen_title.dart';
import '../../models/datetime_slot.dart';

class DoctorDatetimeSlotsScreen extends StatelessWidget {
  const DoctorDatetimeSlotsScreen({
    super.key,
    required this.datetimeSlots,
  });

  final List<DatetimeSlot> datetimeSlots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'My Slots',
        ),
      ),
      body: ListView.builder(
        itemCount: datetimeSlots.length,
        prototypeItem: DatetimeSlotListItem(
          datetimeSlot: datetimeSlots.first,
        ),
        itemBuilder: (context, index) {
          return DatetimeSlotListItem(
            datetimeSlot: datetimeSlots[index],
          );
        },
      ),
    );
  }
}
