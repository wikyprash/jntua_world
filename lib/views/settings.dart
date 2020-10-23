import 'package:flutter/material.dart';
import 'package:jntua_world/controllers/dark_theme_provider.dart';
import 'package:jntua_world/services/auth_services.dart';
import 'package:jntua_world/zres/widgets/custommRRB.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Column(
          children: [
            CustomRRB(
              txt: 'Theme',
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              onPressed: () {
                final themeChange =
                    Provider.of<DarkThemeProvider>(context, listen: false);
                if (themeChange.darkTheme) {
                  setState(() {
                    themeChange.darkTheme = false;
                  });
                } else {
                  setState(() {
                    themeChange.darkTheme = true;
                  });
                }
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomRRB(
                  padding: EdgeInsets.all(0),
                  txt: 'LogOut',
                  onPressed: () {
                    AuthService().signOut();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
