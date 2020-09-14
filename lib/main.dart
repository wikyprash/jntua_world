import 'package:jntua_world/controllers/dark_theme_provider.dart';
import 'package:jntua_world/controllers/styles.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/views/dashboard.dart';
import 'package:jntua_world/views/sign_in_with_google.dart';
import 'package:jntua_world/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // StreamProvider<User>.value(
        //   value: AuthService().user,
        // )
        StreamProvider<User>(
            create: (BuildContext context) => AuthService().user),
        ChangeNotifierProvider(create: (_) => themeChangeProvider)
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'jntua world',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: Scaffold(
              body: AuthHandler(),
            ),
          );
        },
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Dashboard();
    }
  }
}
