import 'package:event_app/pages/event_detail_screen.dart';
import 'package:event_app/pages/event_home_screen.dart';
import 'package:event_app/pages/home_screen.dart';
import 'package:event_app/pages/splash_screen.dart';
import 'package:event_app/services/EventService.dart';
import 'package:event_app/services/TicketService.dart';
import 'package:event_app/services/UserEventDetailService.dart';
import 'package:event_app/services/UserService.dart';
import 'package:event_app/size_config.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        setupSystemSettings();
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: UserService()),
            ChangeNotifierProvider.value(value: EventService()),
            ChangeNotifierProvider.value(value: TicketService()),
            ChangeNotifierProvider.value(value: UserEventDetailService()),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: EventHomeScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => SplashScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
              EventHomeScreen.routeName: (ctx) => EventHomeScreen(),
            },
          ),
        );
      });
    });
  }
}

void setupSystemSettings() {
  // this will change color of status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiDark);

  // this will prevent change oriontation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
