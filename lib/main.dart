import 'package:flutter/material.dart';
import 'package:poop_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import './util/socket_service.dart';
import './util/homescreen_widget.dart';
import './util/app_state_notifier.dart';

// env vars
// String socketUri = "http://172.20.10.3:5000";
String socketUri = "https://ant-personal-site-backend.fly.dev:5000";
String appGroup = "group.anthony.poopapp";
String widgetName = "poopApp";

void main() async {
  // start homescreen widget comms
  WidgetsFlutterBinding.ensureInitialized();
  HomescreenWidget(appGroupIdRef: appGroup, widgetName: widgetName);
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService(socketUri);

  runApp(ChangeNotifierProvider(
      create: (_) => socketService, child: AppStateNotifier(child: MyApp())));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
