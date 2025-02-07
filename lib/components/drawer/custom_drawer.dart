import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  BuildContext buildContext;
  CustomDrawer({super.key, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              'Menu Lateral',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pop(buildContext);
            },
          ),
        ],
      ),
    );
    ;
  }
}
