// class Notification {
//   Notification() {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(
//             defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin,
//         linux: initializationSettingsLinux);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    
//     void onDidReceiveLocalNotification(
//     int id, String? title, String? body, String? payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title??''),
//       content: Text(body??''),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SecondScreen(payload),
//               ),
//             );
//           },
//         )
//       ],
//     ),
//   );
//   }
  
// }