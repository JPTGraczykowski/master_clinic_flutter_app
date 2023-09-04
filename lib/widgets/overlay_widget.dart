import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 64,
        height: 64,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
