import 'package:flutter/material.dart';
import 'package:moteis_go/components/appbar/widgets/app_toggle_buttons.dart';
import 'package:moteis_go/components/appbar/widgets/button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  final String activeButton;
  final Function(String) onToggle;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    Key? key,
    required this.location,
    required this.activeButton,
    required this.onToggle,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFD11621),
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
              AppToggleButtons(
                onToggle: onToggle,
                activeButton: activeButton,
              ),
              Icon(Icons.search, color: Colors.white),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                location,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
