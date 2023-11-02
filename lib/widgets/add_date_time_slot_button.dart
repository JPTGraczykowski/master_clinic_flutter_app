import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';

import '../screens/doctor/datetime_slot_form.dart';

class AddDatetimeSlotButton extends StatelessWidget {
  const AddDatetimeSlotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PrimaryButton(
        content: Text(
          'Add Slot',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DatetimeSlotFormScreen()),
          );
        },
        size: Size(50, 40),
      ),
    );
  }
}
