import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/utils/api_helper.dart';

class ApiDropdownFormField extends StatelessWidget {
  const ApiDropdownFormField({
    super.key,
    required this.url,
    required this.decoration,
    required this.onChanged,
    this.initialId,
  });

  final String url;
  final InputDecoration decoration;
  final void Function(Object?)? onChanged;
  final int? initialId;

  Future<List<Map<String, dynamic>>> get items async {
    final response = await ApiHelper.sendGetRequest(url);
    List<Map<String, dynamic>> items = [];

    if (response != null && response.statusCode == 200) {
      for (Map<String, dynamic> item in response.data as List) {
        items.add(item);
      }

      return items;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Map<String, dynamic>> items = snapshot.data!;

          return DropdownButtonFormField(
            decoration: decoration,
            items: [
              for (final item in items)
                DropdownMenuItem<int>(
                  value: item['id'],
                  alignment: AlignmentDirectional.topStart,
                  child: Text(item['text']),
                )
            ],
            value: initialId,
            onChanged: onChanged,
            elevation: 16,
            menuMaxHeight: 400,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
