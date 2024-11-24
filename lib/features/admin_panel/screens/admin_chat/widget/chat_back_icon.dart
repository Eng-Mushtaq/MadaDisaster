import 'package:flutter/material.dart';

class TChatBackIcon extends StatelessWidget {
  const TChatBackIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.exit_to_app,
              color: iconColor,
            )),
      ],
    );
  }
}
