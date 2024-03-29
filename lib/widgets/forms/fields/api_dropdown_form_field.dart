import 'package:flutter/material.dart';
import 'package:master_clinic_flutter_app/utils/api_helper.dart';

class ApiDropdownFormField extends StatelessWidget {
  const ApiDropdownFormField({
    super.key,
    required this.url,
    required this.decoration,
    required this.onChanged,
    this.initialId,
    this.disabled = false,
    this.renderMenuItemWidget,
  });

  final String url;
  final InputDecoration decoration;
  final void Function(Object?)? onChanged;
  final int? initialId;
  final bool disabled;
  final Widget Function(String)? renderMenuItemWidget;

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
        if (snapshot.hasData) {
          List<Map<String, dynamic>> items = snapshot.data!;

          return DropdownButtonFormField(
            decoration: decoration,
            items: [
              for (final item in items)
                DropdownMenuItem<int>(
                  value: item['id'],
                  alignment: AlignmentDirectional.topStart,
                  child: renderMenuItemWidget != null
                      ? renderMenuItemWidget!(item['text'])
                      : Text(
                          item['text'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                )
            ],
            value: initialId,
            onChanged: disabled ? null : onChanged,
            elevation: 16,
            menuMaxHeight: 400,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
