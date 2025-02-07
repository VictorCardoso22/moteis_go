import 'package:flutter/material.dart';
import 'package:moteis_go/components/appbar/widgets/button.dart';

class AppToggleButtons extends StatelessWidget {
  final Function(String) onToggle;
  String? activeButton;
  AppToggleButtons(
      {super.key, required this.onToggle, required this.activeButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Button(
              text: 'ir agora',
              icon: Icons.flash_on,
              isActive: activeButton == 'ir agora',
              onToggle: onToggle),
          Button(
              text: 'ir outro dia',
              icon: Icons.calendar_today,
              isActive: activeButton == 'ir outro dia',
              onToggle: onToggle),
        ],
      ),
    );
  }
}
