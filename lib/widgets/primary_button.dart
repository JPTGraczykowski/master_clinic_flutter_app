import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.content,
    this.onPressed,
    this.size,
  });

  final Widget content;
  final void Function()? onPressed;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        minimumSize: size ?? Size(200, 50),
      ),
      onPressed: onPressed,
      child: content,
    );
  }
}
