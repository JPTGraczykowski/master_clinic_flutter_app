import 'package:flutter/material.dart';
import '../../widgets/shared/screen_title.dart';
import '../../models/cabinet.dart';
import '../../widgets/cabinet_list_item.dart';

class DoctorCabinetsScreen extends StatelessWidget {
  const DoctorCabinetsScreen({
    super.key,
    required this.cabinets,
  });

  final List<Cabinet> cabinets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(
          title: 'My Cabinets',
        ),
      ),
      body: ListView.builder(
        itemCount: cabinets.length,
        prototypeItem: CabinetListItem(
          cabinet: cabinets.first,
        ),
        itemBuilder: (context, index) {
          return CabinetListItem(
            cabinet: cabinets[index],
          );
        },
      ),
    );
  }
}
