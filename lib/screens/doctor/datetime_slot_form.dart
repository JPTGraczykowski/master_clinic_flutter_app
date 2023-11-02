import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: widget.slotId != null ? 'Edit Slot' : 'New Slot',
        ),
      ),
    );
  }
}
