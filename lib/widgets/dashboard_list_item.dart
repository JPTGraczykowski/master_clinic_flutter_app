import 'package:flutter/material.dart';

class DashboardListItem extends StatelessWidget {
  const DashboardListItem({
    super.key,
    required this.title,
    required this.onSelectItem,
  });

  final String title;
  final void Function() onSelectItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectItem,
      splashColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 0,
        ),
        child: Container(
          height: 50,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
