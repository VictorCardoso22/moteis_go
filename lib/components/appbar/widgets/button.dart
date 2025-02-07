import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String? text;
  IconData? icon;
  bool? isActive;
  final Function(String) onToggle;
  Button(
      {super.key,
      required this.text,
      required this.icon,
      required this.isActive,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(text!),
      child: Container(
        decoration: BoxDecoration(
          color: isActive! ? Colors.white : Color(0xFFB8000C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive! ? Color(0xFFB8000C) : Colors.white,
                size: 14,
              ),
              SizedBox(width: 8),
              Text(
                text!,
                style: TextStyle(
                    color: isActive! ? Color(0xFF393939) : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
